class TaxRate < ActiveRecord::Base
  belongs_to :state
  belongs_to :tax_status
  
  validates :percentage,    :numericality => true, 
                            :presence => true
  validates :tax_status_id, :presence => true
  validates :state_id,      :presence => true
  validates :start_date,    :presence => true
  
end
