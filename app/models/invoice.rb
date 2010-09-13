class Invoice < ActiveRecord::Base
  has_many :payments
  belongs_to :order_id
  
  # after_create :create_authorized_transaction
  
  def create_authorized_transaction
    
  end
  
  def settled!
    # transaction
    settled = true
    save
    # find batch
    
    # Transaction.new(:batch_id => batch.id, )
    # ledger_params = {:accountable_type => 'User', :accountable_id => user_id, :transaction_account_id :amount => amount, :period => period}
    # ReceiveCCPayment.create_transaction(:batch_id => batch.id)
    # 
  end
  
  def user_id
    order.user_id
  end
  
  def user
    order.user
  end
  
  def period
    # order.completed_at calendar_quarter
  end
end
