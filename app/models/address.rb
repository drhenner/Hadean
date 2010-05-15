class Address < ActiveRecord::Base
  belongs_to  :state
  belongs_to  :address_type
  
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state,       :if => Proc.new { |address| address.state_name.blank?  }
  validates_presence_of :state_name,  :if => Proc.new { |address| address.state_id.blank?   }
  validates_presence_of :zip_code
  validates_presence_of :phone
end
