class Batch < ActiveRecord::Base
  belongs_to :batchable, :polymorphic => true
  has_many   :transactions
  
  
end
