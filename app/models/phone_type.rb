class PhoneType < ActiveRecord::Base
  has_many :phones
  
  valiates :presence => true
end
