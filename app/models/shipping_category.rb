class ShippingCategory < ActiveRecord::Base
  has_many :products
end
