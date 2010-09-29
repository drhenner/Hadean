class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
#  devise :database_authenticatable, :registerable, :confirmable,
#         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  include ActiveMerchant::Utils
  
  acts_as_authentic do |config|
    config.validate_email_field
    config.validates_length_of_password_field_options( :minimum => 6, :on => :update, :if => :password_changed? )
    
    # So that Authlogic will not use the LOWER() function when checking login, allowing for benefit of column index.
    config.validates_uniqueness_of_login_field_options :case_sensitive => true
    config.validates_uniqueness_of_email_field_options :case_sensitive => true
    
    config.validate_login_field = true;
    config.validate_email_field = true;
    
    # Remove unecessary field validation given by Authlogic.
    #config.validate_password_field = false;
    
  end

  before_validation :sanitize_data, :before_validation_on_create
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :openid_identifier, :birth_date, :role_ids, :address_attributes, :phone_attributes
  
  has_many    :orders
  has_many    :phones,                    :dependent => :destroy, 
                                          :as => :phoneable
                                          
  has_one     :primary_phone,             :conditions => ['phones.primary = ?', true],
                                          :as => :phoneable
                                          
  has_many    :addresses,                 :dependent => :destroy, 
                                          :as => :addressable
                                          
  has_one     :default_billing_address,   :conditions => ['addresses.billing_default = ? AND active = ?', true, true], 
                                          :as => :addressable,
                                          :class_name => 'Address'
                                          
  has_many    :billing_addresses,         :conditions => ['addresses.active = ?', true], 
                                          :as => :addressable,
                                          :class_name => 'Address'

  has_one     :default_shipping_address,  :conditions => ['addresses.default = ? AND active = ?', true, true], 
                                          :as => :addressable,
                                          :class_name => 'Address'
                                                
  has_many     :shipping_addresses,       :conditions => ['addresses.active = ?', true], 
                                          :as => :addressable,
                                          :class_name => 'Address'
  
  has_many    :user_roles,                :dependent => :destroy
  has_many    :roles,                     :through => :user_roles
  
  has_many    :carts,                     :dependent => :destroy
  
  has_many    :cart_items
  has_many    :shopping_cart_items,       :conditions => ['cart_items.active = ? AND
                                                          cart_items.item_type_id = ?', true, ItemType::SHOPPING_CART_ID], 
                                          :class_name => 'CartItem'
                                                
  has_many    :wish_list_items,           :conditions => ['cart_items.active = ? AND
                                                          cart_items.item_type_id = ?', true, ItemType::WISH_LIST_ID], 
                                          :class_name => 'CartItem'
                                                
  has_many    :purchased_items,           :conditions => ['cart_items.active = ? AND
                                                          cart_items.item_type_id = ?', true, ItemType::PURCHASED_ID], 
                                          :class_name => 'CartItem'
                                                
  has_many    :deleted_cart_items,        :conditions => ['cart_items.active = ?', false], :class_name => 'CartItem'
  has_many    :payment_profiles
  has_many    :transaction_ledgers, :as => :accountable
  
  validates :first_name,  :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :last_name,   :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :email,       :presence => true,
                          :uniqueness => true,
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
  accepts_nested_attributes_for :addresses, :phones, :user_roles
  
  state_machine :state, :initial => :inactive do
    state :inactive
    state :active
    state :unregistered
    state :registered
    state :registered_with_credit
    state :canceled
    
    event :activate do
      transition :inactive => :active
    end
    
    event :register do 
      transition :unregistered => :registered
    end
    
    event :cancel do 
      transition :all => :canceled
    end
    
  end
  
  def active?
    !['canceled', 'inactive'].any? {|s| self.state == s }
  end
  
  def role?(role_name)
    roles.any? {|r| r.name == role_name.to_s}
  end
  
  def admin?
    role?(:administrator) || role?(:super_administrator)
  end
  
  def super_admin?
    role?(:super_administrator)
  end
  
  def display_active
    active?.to_s
  end
  
  def current_cart
    carts.last
  end
  ##  This method will one day grow into the products a user most likely likes.  
  #   Storing a list of product ids vs cron each night might be the most efficent mode for this method to work.
  def might_be_interested_in_these_products
    Product.limit(4).find(:all)
  end
  
  def billing_address
    default_billing_address ? default_billing_address : default_shipping_address
  end
  
  def registered_user?
    registered? || registered_with_credit?
  end
  
  def name 
    (first_name? && last_name?) ? [first_name.capitalize, last_name.capitalize ].join(" ") : email
  end

  def sanitize_data
    self.email      = self.email.strip.downcase       unless email.blank?
    self.first_name = self.first_name.strip.capitalize  unless first_name.nil?
    self.last_name  = self.last_name.strip.capitalize   unless last_name.nil?
    
    ## CHANGE THIS IF YOU HAVE DIFFERENT ACCOUNT TYPES
    unless account_id
      account = Account.first
    end
  end
  
  def deliver_activation_instructions!
    Notifier.signup_notification(self).deliver
  end
  
  def email_address_with_name
    "\"#{name}\" <#{email}>"
  end
  
  def get_cim_profile
    return customer_cim_id if customer_cim_id
    create_cim_profile
    customer_cim_id
  end
  
  def merchant_description
    [name, default_shipping_address.try(:address_lines)].compact.join(', ')
  end
  
  def self.admin_grid(params = {})
    
    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = Table(:variants)
    
    grid = User
    grid = grid.includes(:roles)
    grid = grid.where("users.first_name LIKE ?", "%#{params[:first_name]}%") if params[:first_name].present?
    grid = grid.where("users.last_name LIKE ?",  "%#{params[:last_name]}%")  if params[:last_name].present?
    grid = grid.where("users.email LIKE ?",      "%#{params[:email]}%")      if params[:email].present?
    grid = grid.order("#{params[:sidx]} #{params[:sord]}") 
    grid = grid.limit(params[:rows])
    grid.paginate({:page => params[:page]})
  end
  
  private
  
  def create_cim_profile
    return true if customer_cim_id
    #Login to the gateway using your credentials in environment.rb
    @gateway = get_payment_gateway
    
    #setup the user object to save
    @user = {:profile => user_profile}
    
    #send the create message to the gateway API
    response = @gateway.create_customer_profile(@user)
    
    if response.success? and response.authorization
      update_attributes({:customer_cim_id => response.authorization})
      return true
    end
    return false
  end
  
  def user_profile
    return {:merchant_customer_id => self.id, :email => self.email, :description => self.merchant_description}
  end
  
  def before_validation_on_create
    self.access_token = ActiveSupport::SecureRandom::hex(9+rand(6)) if self.new_record? and self.access_token.nil?
  end
end
