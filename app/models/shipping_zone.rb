class ShippingZone < ActiveRecord::Base
  has_many :shipping_methods
  ## if your model requires more shipping zones create a join table and delete state.shipping_zone_id
  #has_many :state_shipping_zones
  has_many :states#, :through => :state_shipping_zones
  
  USA48         = 'USA'
  ALASKA_HAWAII = 'Alaska and Hawaii'
  CANADA        = 'Canada'
  USA_TERRITORY = 'USA Territory'
  
  LOCATIONS     = [USA48, ALASKA_HAWAII, CANADA, USA_TERRITORY]
  
  accepts_nested_attributes_for :states
end
