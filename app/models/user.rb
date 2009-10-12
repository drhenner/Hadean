class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :password, :password_salt, :password_confirmation, :login

  has_many :names, :as => :nameable
  has_many :emails, :as => :emailable
  accepts_nested_attributes_for :names
  attr_accessible :names_attributes
  accepts_nested_attributes_for :emails
  attr_accessible :emails_attributes
  
  has_one  :active_name,  :class_name => "Name",  :conditions => {:active => true}
  has_one  :active_email, :class_name => "Email", :conditions => {:active => true}
end
