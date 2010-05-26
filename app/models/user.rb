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
  
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  #has_one     :registration_info
  has_many    :addresses,                       :dependent => :destroy
  has_many    :user_roles,                      :dependent => :destroy
  has_many    :roles,         :through => :user_roles
  
  #default_scope :include => [:registration_info]
  
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
  
  def name 
    (first_name? && last_name?) ? [first_name, last_name ].join(" ") : email
  end
  
end
