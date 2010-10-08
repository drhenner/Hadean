class ReturnAuthorization < ActiveRecord::Base
  has_many   :return_items
  has_many   :comments, :as => :commentable
  
  belongs_to :user
  belongs_to :author, :class_name => 'User', :foreign_key => :created_by
  # has_many :transactions
  has_many    :transaction_ledgers, :as => :accountable
  
  accepts_nested_attributes_for :return_items,  :reject_if => proc { |attributes| attributes['return_reason_id'].blank? || 
                                                                                  attributes['return_condition_id'].blank? }
  accepts_nested_attributes_for :comments,      :reject_if => proc { |attributes| attributes['note'].blank? }
  
  ## after you process an RMA you must manually add the variant back into the system!!!
  state_machine :initial => 'authorized' do
    #after_transition :to => 'received', :do => :process_receive
    #after_transition :to => 'cancelled', :do => :process_canceled
    #before_transition :to => 'complete', :do => :process_ledger_transactions
    
    event :receive do
      transition :to => 'received', :from => 'authorized'
    end
    event :cancel do
      transition :to => 'cancelled', :from => 'authorized'
    end
    event :complete do # do this after a payment was returned to the customer
      transition :to => 'complete', :from => 'authorized'
    end
  end
  
  def process_ledger_transactions
    ##  credit => cash
    ##  debit  => revenue
  end
  
  def order_number
    order.number
  end
  
  def user_name
    user.name
  end
  
  def self.admin_grid(params)

    params[:page] ||= 1
    params[:rows] ||= SETTINGS[:admin_grid_rows]

    grid = ReturnAuthorization.includes([:order, :user])#paginate({:page => params[:page]})

    grid = grid.where("return_authorizations.number LIKE ?",  "#{params[:number]}%")        if params[:number].present?
    grid = grid.where("orders.order_number LIKE ?",           "#{params[:order_number]}%")  if params[:order_number].present?
    grid = grid.where("return_authorizations.state = ?",      params[:state])               if params[:state].present?
    grid = grid.limit(params[:rows])
    grid = grid.order("#{params[:sidx]} #{params[:sord]}").paginate(:page => params[:page], :per_page => params[:rows])
  end
end
