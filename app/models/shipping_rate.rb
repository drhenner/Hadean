class ShippingRate < ActiveRecord::Base
  belongs_to :shipping_category
  belongs_to :shipping_method
  belongs_to :shipping_rate_type
  
  has_many :shipping_categories
  has_many :products, :through => :shipping_categories
  
  validates  :rate,                   :presence => true, :numericality => true
  
  validates  :shipping_method_id,     :presence => true
  validates  :shipping_rate_type_id,  :presence => true
  
  def name
    [shipping_method.name, shipping_method.shipping_zone.name, sub_name].join(', ')
  end
  
  def sub_name
    '(' + [shipping_rate_type.name, rate ].join(' - ') + ')'
  end
  
end
