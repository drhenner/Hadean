class TransactionLedger < ActiveRecord::Base
  belongs_to :transaction_account
  belongs_to :transaction
  belongs_to :accountable, :polymorphic => true
  
  
end
