class VariantProperty < ActiveRecord::Base
  
  belongs_to :variant
  belongs_to :propery
  
  validates :variant_id,  :presence => true
  validates :propery_id,  :presence => true

end
