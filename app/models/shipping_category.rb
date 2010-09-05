class ShippingCategory < ActiveRecord::Base
  has_many :products
  has_many :shipping_rates
end
