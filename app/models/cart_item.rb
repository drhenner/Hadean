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
end
