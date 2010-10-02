class Shipment < ActiveRecord::Base
  belongs_to :order
  belongs_to :shipping_method
  belongs_to :address#, :polymorphic => true
  has_many   :order_items
  
  before_validation :set_number
  
  validates :order_id,            :presence => true
  validates :address_id,          :presence => true
  validates :shipping_method_id,  :presence => true
  
  state_machine :initial => 'pending' do
    
    event :prepare do
      transition :to => 'ready_to_ship', :from => 'pending'
    end
    
    event :ship do
      transition :to => 'shipped', :from => 'ready_to_ship'
    end
    
  end
  
  def display_shipped_at(format)
    shipped_at ? shipped_at.strftime(format) : 'Not Shipped.'
  end
  
  def self.create_shipments_with_items(order)
    order.order_items.group_by(&:shipping_method_id).each do |shipping_method_id, order_items|
      shipment = Shipment.new(:shipping_method_id => shipping_method_id, 
                              :address_id         => order.ship_address_id,
                              :order_id           => order.id
                              )
      order_items.each do |item|
        shipment.order_items.push(item)
      end
      shipment.prepare!
    end
  end
  
  def set_number
    self.number = [order_id.to_s(20), (Time.now.to_i).to_s(21)].join('-')
  end
end
