class Cart < ActiveRecord::Base
  belongs_to  :user
  has_many    :cart_items
  has_many    :shopping_cart_items,       :conditions => ['cart_items.active = ? AND
                                                          cart_items.item_type_id = ?', true, ItemType::SHOPPING_CART_ID], 
                                          :class_name => 'CartItem'
                                                
  has_many    :wish_list_items,           :conditions => ['cart_items.active = ? AND
                                                          cart_items.item_type_id = ?', true, ItemType::WISH_LIST_ID], 
                                          :class_name => 'CartItem'
                                                
  has_many    :purchased_items,           :conditions => ['cart_items.active = ? AND
                                                          cart_items.item_type_id = ?', true, ItemType::PURCHASED_ID], 
                                          :class_name => 'CartItem'
                                                
  has_many    :deleted_cart_items,        :conditions => ['cart_items.active = ?', false], :class_name => 'CartItem'
  
  
  def sub_total
    shopping_cart_items.includes(:variant).inject(0) {|sum, item| item.total + sum}
  end
  
  def add_variant(variant_id, customer, cart_item_type_id = ItemType::SHOPPING_CART_ID)# customer is a user
    items = shopping_cart_items.find_all_by_variant_id(variant_id)
    variant = Variant.find(variant_id)
    if items.size < 1
      cart_item = cart_items.create(:variant_id   => variant_id,
                                    :user         => customer,
                                    :item_type_id => cart_item_type_id,
                                    :quantity     => 1#,#:price      => variant.price
                                    )
    else
      cart_item = items.first
      update_cart(cart_item,customer)
    end
    cart_item
  end
  
  def remove_variant(variant_id)
    ci = shopping_cart_items.find_by_variant_id(variant_id)
    ci.inactivate!
    return ci
  end
  
  def save_user(u)  # u is user object or nil
    if u && self.user_id != u.id
      self.user_id = u.id
      self.save
    end
  end
  
  private
  def update_cart(cart_item,customer)
    if customer
      cart_item.update_attributes(:quantity => (cart_item.quantity + 1), :user_id => customer.id)
    else
      cart_item.update_attributes(:quantity => (cart_item.quantity + 1))
    end
  end
end
