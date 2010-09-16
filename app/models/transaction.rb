class Transaction < ActiveRecord::Base
  belongs_to :batch
  
  has_many :transaction_ledgers
  
end
