class ItemType < ActiveRecord::Base
  has_many :carts
  NAMES = ['shopping_cart', 'save_for_later', 'wish_list', 'purchased']
end
