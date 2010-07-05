class PrototypePropertiesProductType < ActiveRecord::Base
  belongs_to :prototype_property
  belongs_to :product_type
  
  
  validates :variant_id,  :presence => true
  validates :propery_id,  :presence => true
end
