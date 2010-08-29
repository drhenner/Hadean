class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
#  devise :database_authenticatable, :registerable, :confirmable,
#         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
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

  before_validation :sanitize_data
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :openid_identifier, :birth_date, :address_attributes, :phone_attributes
  
  has_many    :phones,                    :dependent => :destroy, 
                                          :as => :phoneable
                                          
  has_one     :primary_phone,             :conditions => ['phones.primary = ?', true],
                                          :as => :phoneable
                                          
  has_many    :addresses,                 :dependent => :destroy, 
                                          :as => :addressable
                                          
  has_one     :default_billing_address,   :conditions => ['addresses.default = ? AND
                                                          addresses.address_type_id = ?', true, AddressType::BILLING_ID], 
                                          :as => :addressable
                                                
  has_one     :default_shipping_address,  :conditions => ['addresses.default = ? AND
                                                          addresses.address_type_id = ?', true, AddressType::SHIPPING_ID], 
                                          :as => :addressable
                                                
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
  
  
  
  validates :first_name,  :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :last_name,   :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :email,       :presence => true,
                          :uniqueness => true,
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
  accepts_nested_attributes_for :addresses, :phones
  
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
  
  def current_cart
    carts.last
  end
  ##  This method will one day grow into the products a user most likely likes.  
  #   Storing a list of product ids vs cron each night might be the most efficent mode for this method to work.
  def might_be_interested_in_these_products
    Product.limit(4).find(:all)
  end
  
  def registered_user?
    registered? || registered_with_credit?
  end
  
  def name 
    (first_name? && last_name?) ? [first_name.capitalize, last_name.capitalize ].join(" ") : email
  end

  def sanitize_data
    self.email      = self.email.strip.downcase       unless email.blank?
    self.first_name = self.first_name.strip.downcase  unless first_name.nil?
    self.last_name  = self.last_name.strip.downcase   unless last_name.nil?
  end
  
  def deliver_activation_instructions!
    Notifier.signup_notification(self).deliver
  end
  
  def email_address_with_name
    "\"#{name}\" <#{email}>"
  end
end
