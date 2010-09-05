class ShippingRate < ActiveRecord::Base
  belongs_to :shipping_category
  belongs_to :shipping_method
  belongs_to :shipping_rate_type
  
  validates  :rate,                   :presence => true, :numericality => true
  
  validates  :shipping_method_id,     :presence => true
  validates  :shipping_rate_type_id,  :presence => true
  
end
