class Invoice < ActiveRecord::Base
  has_many :payments
  has_many :batches, :as => :batchable#, :polymorphic => true
  belongs_to :order
  
  
  #cattr_accessor :gateway
  
  # after_create :create_authorized_transaction
  
  def create_authorized_transaction
    
  end
  state_machine :initial => :pending do
    state :pending
    state :authorized
    state :paid
    state :payment_declined
    state :canceled
    
    after_transition :to => 'authorized', :do => :authorize_complete_order
    
    event :payment_authorized do
      transitions :from => :pending,
                  :to   => :authorized
      transitions :from => :payment_declined,
                  :to   => :authorized
    end
    event :payment_captured do
      transitions :from => :authorized,
                  :to   => :paid
    end
    event :transaction_declined do
      transitions :from => :pending,
                  :to   => :payment_declined
      transitions :from => :payment_declined,
                  :to   => :payment_declined
      transitions :from => :authorized,
                  :to   => :authorized
    end
  end
  
  def authorize_complete_order(amount)
    order.complete!
    now = Time.zone.now
    if batches.empty?
      batch = self.batches.new()
      transaction = CreditCardPayment.new()##  This is a type of transaction
      credit = order.user.transaction_ledgers.new(:transaction_account_id => TransactionAccount::REVENUE_ID, :debit => 0, :credit => amount, :period => "#{now.month}-#{now.year}")
      debit  = order.user.transaction_ledgers.new(:transaction_account_id => TransactionAccount::ACCOUNTS_RECEIVABLE_ID, :debit => amount, :credit => 0, :period => "#{now.month}-#{now.year}")
      transaction.transaction_ledgers.push(credit)
      transaction.transaction_ledgers.push(debit)
      batch.transactions.push(transaction)
      batch.save
    else
      raise error ###  something messed up I think
    end
    # batch.transactions.push(transaction)
    # Transaction.new(:batch_id => batch.id, )
    # ledger_params = {:accountable_type => 'User', 
    #                 :accountable_id => user_id, 
    #                 :transaction_account_id 
    #                 :amount => amount, :period => period}
    # ReceiveCCPayment.create_transaction(:batch_id => batch.id)
    # 
  end
  
  def unique_order_number
    "#{Time.now.to_i}-#{order.number}"
  end
  
  def authorization_reference
    if authorization = payments.find_by_action_and_success('authorization', true, :order => 'id ASC')
      authorization.reference
    end
  end
  
  def succeeded?
    payment_authorized? || payment_captured?
  end
  
  def authorize_payment(credit_card, options = {})
    options[:invoice_id] ||= unique_order_number
    transaction do
      authorization = Payment.authorize(amount, credit_card, options)
      payments.push(authorization)
      if authorization.success?
        payment_authorized!
      else
        transaction_declined!
      end
      authorization
    end
  end
  
  def capture_payment(options = {})
    transaction do
      capture = Payment.capture(amount, authorization_reference, options)
      payments.push(capture)
      if capture.success?
        payment_captured!
      else
        transaction_declined!
      end
      capture
    end
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
