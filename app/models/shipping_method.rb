class ShippingMethod < ActiveRecord::Base
  has_many :shipping_rates
  belongs_to :shipping_zone
end
