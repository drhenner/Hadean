class Prototype < ActiveRecord::Base
  
  has_many :prototype_properties
  has_many :properties,          :through => :prototype_properties
  
  validates :name,    :presence => true
  
end
