class PrototypeProperty < ActiveRecord::Base
  
  belongs_to :prototype
  belongs_to :property
  
  validates_presence_of :prototype_id, :property_id
end
