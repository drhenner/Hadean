class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  has_one     :registration_info
  has_many    :addresses,                       :dependent => :destroy
  has_many    :user_roles,                      :dependent => :destroy
  has_many    :roles,         :through => :user_roles
  
  default_scope :include => [:registration_info]
end
