class PrototypeProperty < ActiveRecord::Base
  
  belongs_to :prototype
  belongs_to :properties
  
  has_many :prototype_properties_product_types
  has_many :product_types,      :through => :prototype_properties_product_types
  
  validates_presence_of :prototype_id, :propery_id
end
