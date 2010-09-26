class CartItem < ActiveRecord::Base
  belongs_to :item_type
  belongs_to :user
  belongs_to :cart
  belongs_to :variant
  
  belongs_to :session
  
  def price
    variant.price
  end
  
  def total
    price * quantity
  end
  
  def inactivate!
    self.update_attributes(:active => false)
  end
  
  def self.mark_items_purchased(cart, order)
    CartItem.update_all("item_type_id = #{ItemType::PURCHASED_ID}", "id IN (#{cart.cart_item_ids.join(',')}) AND variant_id IN (#{order.variant_ids.join(',')})")
  end
end
