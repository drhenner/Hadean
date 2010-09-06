class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :shipping_rate
  belongs_to :variant
 # belongs_to :tax_rate
 
 
 state_machine :initial => 'unpaid' do
   
   
   #after_transition :to => 'complete', :do => [:update_inventory]
 end
 
  def self.order_items_in_cart(order_id)
    find(:all, :conditions => ['order_items.order_id = ? ', order_id ],
               :select => "order_items.*, count(*) as quantity, 
                                          SUM(order_items.price) as sum_price,
                                          SUM(order_items.total) as sum_total",
               :group => "order_items.variant_id")
  end
  
end
