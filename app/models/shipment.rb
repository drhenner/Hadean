class Shipment < ActiveRecord::Base
  belongs_to :order
  belongs_to :shipping_method
  belongs_to :address#, :polymorphic => true
  has_many   :order_items
  
  def display_shipped_at(format)
    shipped_at ? shipped_at.strftime(format) : 'Not Shipped.'
  end
  
  
end
