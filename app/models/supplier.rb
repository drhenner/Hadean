class Supplier < ActiveRecord::Base
  
  has_many :variant_suppliers
  has_many :variants,         :through => :variant_suppliers
  
  
  validates :name,        :presence => true
  validates :email,       :presence => false, 
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
end
