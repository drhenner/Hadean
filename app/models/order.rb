class Order < ActiveRecord::Base
  has_friendly_id :number, :use_slug => false
  
  has_many   :order_items
  has_many   :shipments
  has_many   :invoices
  has_many   :completed_invoices,  :class_name => 'Invoice', :conditions => ['state = ? OR state = ?', 'authorized', 'paid']
  has_many   :authorized_invoices, :class_name => 'Invoice', :conditions => ['state = ?', 'authorized']
  has_many   :paid_invoices      , :class_name => 'Invoice', :conditions => ['state = ?', 'paid']
  
  belongs_to :user
  belongs_to   :ship_address, :class_name => 'Address'
  belongs_to   :bill_address, :class_name => 'Address'
  
  before_validation :set_email
  after_create      :set_order_number
  before_save       :update_tax_rates
    
  
  after_find :set_beginning_values
    
  attr_accessor :total, :sub_total
  
  #validates :number,     :presence => true
  validates :user_id,     :presence => true
  validates :email,       :presence => true,
                          :format   => { :with => CustomValidators::Emails.email_validator }
  
  state_machine :initial => 'in_progress' do
    
    event :complete do
      transition :to => 'complete', :from => 'in_progress'
    end
    
    #before_transition :to => 'complete', :do => [:set_completed]
    #after_transition  :to => 'complete', :do => [:update_inventory]
  end
  
  #########
  ##  This method is used when the session in admin orders is ready to authorize the credit card
  #   The cart has the following format
  #
  #  session[:admin_cart] = {
  #    :user             => nil,
  #    :shipping_address => nil,
  #    :billing_address  => nil,
  #    :coupon           => nil,
  #    :shipping_method  => nil,
  #    :order_items => {}# the key is variant_id , a hash of {variant, shipping_rate, quantity, tax_rate, total, shipping_category_id}
  #  }
  
  def first_invoice_amount
    return '' if completed_invoices.empty?
    completed_invoices.first.amount
  end
  
  def status
    return 'not processed' if invoices.empty?
    invoices.last.state
  end
  
  def self.find_myaccount_details
    includes([:completed_invoices, :invoices])
  end
  
  def self.new_admin_cart(admin_cart, args)
    #transaction do 
      admin_order = Order.new(  :ship_address     => admin_cart[:shipping_address],
                                :bill_address     => admin_cart[:billing_address],
                                :coupon           => admin_cart[:coupon],
                                :shipping_method  => admin_cart[:shipping_method],
                                :email            => admin_cart[:user].email,
                                :user             => admin_cart[:user],
                                #:ip_address       => args[:ip_address],
                                :email            => admin_cart[:user].email
                            )
      admin_cart[:order_items].each_pair do |variant_id, hash|
          hash[:quantity].times do
              item = OrderItem.new( :variant        => hash[:variant],
                                    :tax_rate       => hash[:tax_rate],
                                    :price          => hash[:variant].price,
                                    :total          => hash[:total],
                                    :shipping_rate  => hash[:shipping_rate]
                                )
              admin_order.order_items.push(item)
          end
      end
      admin_order.save
      
    #end
  end
  
  ## This method creates the invoice and payment method.  If the payment is not authorized the whole transaction is roled back
  def create_invoice(credit_card, charge_amount, args)
    transaction do 
      create_invoice_transaction(credit_card, charge_amount, args)
    end
  end
  
  def create_invoice_transaction(credit_card, charge_amount, args)
    invoice_statement = Invoice.generate(self.id, charge_amount, "#{Time.now.to_i}-#{number}")
    invoice_statement.save
    invoice_statement.authorize_payment(credit_card, args)#, options = {})
    invoices.push(invoice_statement)
    if invoice_statement.succeeded?
      self.order_complete! #complete!
    else
      debugger
      role_back
      false
    end
    invoice_statement
  end
  
  
  def order_complete!
    self.state = 'complete'
    self.completed_at = Time.zone.now
    update_inventory
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
    if calculated_at.nil? || (order_items.any? {|item| (item.updated_at > self.calculated_at) })
      unless order_items.any? {|item| !item.ready_to_calculate? }
        total = 0.0
        tax_time = completed_at? ? completed_at : Time.zone.now
        order_items.each do |item|
          if (calculated_at.nil? || item.updated_at > self.calculated_at)
            item.tax_rate = item.variant.product.tax_rate(self.ship_address.state_id, tax_time)## This needs to change to completed_at
            item.calculate_total
            item.save
          end
          total = total + item.total
        end
        sub_total = total
        total = total + shipping_charges
        self.calculated_at = Time.now
        save
      end
    end
  end
  
  def order_total(force = false)
    find_total
  end
  
  def ready_to_checkout?
    order_items.all? {|item| item.ready_to_calculate? }
  end
  
  def find_total(force = false)
    calculate_totals if self.calculated_at.nil? || order_items.any? {|item| (item.updated_at > self.calculated_at) }
    self.total = 0.0
    order_items.each do |item|
      self.total = self.total + item.total
    end
    self.sub_total = self.total
    self.total = self.total + shipping_charges
  end
  
  def shipping_charges
    return @order_shipping_charges if defined?(@order_shipping_charges)
    items = OrderItem.order_items_in_cart(self.id)
    charged_items = items.inject([]) do |charged_items, item| 
      charged_items << item if item.shipping_rate.shipping_rate_type_id == ShippingRateType::INDIVIDUAL || !charged_items.map{|i| i.shipping_rate }.include?(item.shipping_rate)
      charged_items
    end
    @order_shipping_charges = charged_items.inject(0.0) {|sum, item|  sum + item.shipping_rate.rate  }
  end
  
  def update_address(address_type_id , address_id)
    if address_type_id == AddressType::SHIPPING_ID
      self.update_attributes(:ship_address_id => address_id)
    elsif address_type_id == AddressType::BILLING_ID
      self.update_attributes(:bill_address_id => address_id)
    end
    self
  end
  
  def add_items(variant, quantity, state_id = nil)
    self.save! if self.new_record?
    tax_rate_id = state_id ? variant.product.tax_rate(state_id) : nil
    quantity.times do
      self.order_items.create(:variant_id => variant.id, :price => variant.price, :tax_rate_id => tax_rate_id)
    end
  end
  
  def new_items(variant, quantity, state_id = nil)
    tax_rate_id = state_id ? variant.product.tax_rate(state_id) : nil
    quantity.times do
      self.order_items.new(:variant_id => variant.id, :price => variant.price, :tax_rate_id => tax_rate_id)
    end
  end
  
  def set_email
    self.email = user.email if user_id
  end
  
  def set_order_number
    if !self.number?
      self.number = (1001001001000 + id).to_s(21)
      save
    end
  end
  
  ## This method is called when the order transitions to paid
  def update_inventory
    self.order_items.each {|item| item.variant.add_pending_to_customer(1) }
  end
  
  def variant_ids
    order_items.collect{|oi| oi.variant_id }
  end
end
