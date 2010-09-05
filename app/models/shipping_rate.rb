class ShippingRate < ActiveRecord::Base
  belongs_to :shipping_category
  belongs_to :shipping_method
  belongs_to :shipping_rate_types
  
  validates  :rate  :presence => true
  
  
end
