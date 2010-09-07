class TaxRate < ActiveRecord::Base
  belongs_to :state
  belongs_to :tax_status
end
