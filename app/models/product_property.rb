class ProductProperty < ActiveRecord::Base
  belongs_to :product
  belongs_to :property
  
  validates_presence_of :product_id, :propery_id
  
end
