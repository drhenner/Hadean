class AddressType < ActiveRecord::Base
  has_many :addresses
  
  validates_presence_of :name
  BILLING   = 'Billing'
  SHIPPING  = 'Shipping'
  #ORDER     = 'Order'
  NAMES     = [BILLING, SHIPPING] #, ORDER
  
  BILLING_ID  = 1
  SHIPPING_ID = 2
  #ORDER_ID    = 3
  
  
end
