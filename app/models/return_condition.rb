class ReturnCondition < ActiveRecord::Base
  has_many :return_items
  
  GOOD      = 'Good'
  DEFECTIVE = 'Defective'
  DAMAGED   = 'Worn / Damaged'
  
  CONDITIONS = [GOOD, DEFECTIVE, DAMAGED]
  
end
