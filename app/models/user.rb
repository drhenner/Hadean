class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
#  devise :database_authenticatable, :registerable, :confirmable,
#         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  acts_as_authentic do |config|
    config.validate_email_field
    config.validates_length_of_password_field_options( :minimum => 8, :on => :update, :if => :password_changed? )
  end
  
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :address_attributes
  
  #has_one     :registration_info
  has_many    :addresses,                       :dependent => :destroy, 
                                                :as => :addressable
                                                
  has_one     :default_address,                 :conditions => ['default = ?', true], 
                                                :as => :addressable
                                                
  has_many    :user_roles,                      :dependent => :destroy
  has_many    :roles,         :through => :user_roles
  
  validates_presence_of :first_name, :last_name, :if => :registered_user?
  validates_presence_of :email
  #default_scope :include => [:registration_info]
  
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
