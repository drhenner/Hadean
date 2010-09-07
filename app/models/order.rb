class Order < ActiveRecord::Base
  belongs_to :user
  has_many   :order_items
  belongs_to   :ship_address, :class_name => 'Address'
  belongs_to   :bill_address, :class_name => 'Address'
  
  
  before_validation :set_email
  after_create      :set_order_number
  before_save       :update_tax_rates
    
  
  after_find :set_beginning_values
    
  attr_accessor :total
  
  validates :user_id,     :presence => true
  validates :email,       :presence => true,
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
  state_machine :initial => 'in_progress' do
    
    event :complete do
      transition :to => 'complete', :from => 'in_progress'
    end
    
    after_transition :to => 'complete', :do => [:update_inventory]
  end
  
  def set_beginning_values
    @beginning_address_id      = ship_address_id # this stores the initial value of the tax_rate
  end
  
  def update_tax_rates
    if @beginning_address_id != ship_address_id
      tax_time = completed_at? ? completed_at : Time.zone.now
      order_items.each do |item|
        rate = item.variant.product.tax_rate(self.ship_address.state_id, tax_time)
        if item.tax_rate_id != rate.id 
          item.tax_rate = rate
          item.save
        end
      end
    end
  end
  
  def calculate_totals(force = false)
    if order_items.any? {|item| (self.calculated_at.nil? || item.updated_at > self.calculated_at) }
      unless order_items.any? {|item| !item.ready_to_calculate? }
        total = 0.0
        tax_time = completed_at? ? completed_at : Time.zone.now
        order_items.each do |item|
          if (calculated_at.nil || item.updated_at > self.calculated_at)
            item.tax_rate = item.variant.product.tax_rate(self.ship_address.state_id, tax_time)## This needs to change to completed_at
            item.calculate_total
            item.save
          end
          total = total + item.total
        end
        total = total + shipping_charges
        self.calculated_at = Time.now
        save
      end
    end
  end
  
  def order_total(force = false)
    return total if total || force
    find_total
  end
  
  def find_total
    calculate_totals if order_items.any? {|item| (calculated_at.nil || item.updated_at > self.calculated_at) }
    total = 0.0
    order_items.each do |item|
      total = total + item.total
    end
    total = total + shipping_charges
  end
  
  def shipping_charges
    items = OrderItem.order_items_in_cart(self.id)
    charges = items.inject(0.0) {|total, item|  total + item.shipping_rate.rate  }
  end
  
  def update_address(address_type_id , address_id)
    if address_type_id == AddressType::SHIPPING_ID
      self.update_attributes(:ship_address_id => address_id)
    elsif address_type_id == AddressType::BILLING_ID
      self.update_attributes(:bill_address_id => address_id)
    end
    self
  end
  
  def add_items(variant, quantity)
    quantity.times do
      self.order_items.create(:variant_id => variant.id, :price => variant.price, :tax_rate_id => variant.product.tax_rate())
    end
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
