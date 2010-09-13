class TransactionAccount < ActiveRecord::Base
  has_many :transaction_ledgers
end
