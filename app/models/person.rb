class Person < ActiveRecord::Base
  has_many :names
  has_many :emails

  has_one  :active_name,  :classname => "Name",  :conditions => {:active => true}
  has_one  :active_email, :classname => "Email", :conditions => {:active => true}
end
