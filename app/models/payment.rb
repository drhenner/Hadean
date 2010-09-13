class Payment < ActiveRecord::Base
  belongs_to :invoice_id
  
  # after_save :mark_invoice_complete
  
  def mark_invoice_complete
    if self.confirmation_id && !invoice.settled?
      invoice.settled!
    end
  end
end
