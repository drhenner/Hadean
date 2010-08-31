class Account < ActiveRecord::Base
  
  FREE  = 'Free'
  TYPES = {FREE => 0.00}
end
