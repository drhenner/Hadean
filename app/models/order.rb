class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :order_items
  
  
  before_validation :set_email
  after_create      :set_order_number
    
  validates :user_id,     :presence => true
  validates :email,       :presence => true,
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
  state_machine :initial => 'in_progress' do
    
    after_transition :to => 'complete', :do => [:update_inventory]
  end
  
  def update_address(address_type_id , address_id)
    if address_type_id == AddressType::SHIPPING_ID
      self.update_attributes(:ship_address_id => address_id)
    elsif address_type_id == AddressType::BILLING_ID
      self.update_attributes(:bill_address_id => address_id)
    end
    self
  end
  
  def set_email
    self.email = user.email if user_id
  end
  
  def set_order_number
    unless number?
      number = (1001001001000 + id).to_s(21)
      save
    end
  end
  
  ## This method is called when the order transitions to paid
  def update_inventory
    self.order_items.each {|item| item.variant.add_pending_to_customer(1) }
  end
end
