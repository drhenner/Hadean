class AddressType < ActiveRecord::Base
  has_many :addresses
  
  validates_presence_of :name
  
  NAMES = ['shipping', 'billing', 'order']
  
end
