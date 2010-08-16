class PurchaseOrderVariant < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :variant
  
  
  ## This method will need a rescue method i assume.
  def receive! 
    PurchaseOrderVariant.transaction do
      ###  Add to variant stock level
      self.variant.count_on_hand = self.variant.count_on_hand + self.quantity
      if self.variant.save!
        ### change is_received to true
        self.is_received = true
        self.save!
      end
    end
  end
end
