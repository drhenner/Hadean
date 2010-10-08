class ReturnCondition < ActiveRecord::Base
  has_many :return_items
  
  GOOD      = 'Good'
  DEFECTIVE = 'Defective'
  DAMAGED   = 'Worn / Damaged'
  
  CONDITIONS = [GOOD, DEFECTIVE, DAMAGED]
  
  def self.select_form
    all.collect {|r| [r.label, r.id]}
  end
  
end
