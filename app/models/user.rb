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
    config.validate_password_field = false;
    
  end
  
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :address_attributes
  
  has_many    :phones,                          :dependent => :destroy, 
                                                :as => :phoneable
  
  has_one     :primary_phone,                   :conditions => ['phones.primary = ?', true],
                                                :as => :phoneable
  
  has_many    :addresses,                       :dependent => :destroy, 
                                                :as => :addressable
                                                
  has_one     :default_address,                 :conditions => ['addresses.default = ?', true], 
                                                :as => :addressable
                                                
  has_many    :user_roles,                      :dependent => :destroy
  has_many    :roles,         :through => :user_roles
  
  validates :first_name,  :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :last_name,   :presence => true, :if => :registered_user?,
                          :format   => { :with => CustomValidators::Names.name_validator }
  validates :email,       :presence => true,
                          :uniqueness => true,
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
  accepts_nested_attributes_for :addresses
  
  state_machine :state, :initial => :unregistered do
    state :unregistered
    state :registered
    state :registered_with_credit
    state :canceled
    
    event :register do 
      transition :unregistered => :registered
    end
    
    event :cancel do 
      transition :all => :canceled
    end
    
  end
  
  def registered_user?
    registered? || registered_with_credit?
  end
  
  def name 
    (first_name? && last_name?) ? [first_name, last_name ].join(" ") : email
  end

  
end
