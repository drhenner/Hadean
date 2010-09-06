class ShippingCategory < ActiveRecord::Base
  belongs_to :product
  belongs_to :shipping_rate
  
  
end
