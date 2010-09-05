class ShippingZone < ActiveRecord::Base
  has_many :shipping_methods
  
  USA48         = 'USA'
  ALASKA_HAWAII = 'Alaska and Hawaii'
  CANADA        = 'Canada'
  
  LOCATIONS     = [USA48, ALASKA_HAWAII, CANADA]
  
end
