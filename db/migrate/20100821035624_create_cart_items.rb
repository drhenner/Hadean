class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.integer :user_id
      t.integer :cart_id
      t.integer :variant_id,                    :null => false
      t.integer :quantity,    :default => 1
      t.boolean :active,      :default => true
      t.integer :item_type_id,                  :null   => false

      t.timestamps
    end
    
    add_index :carts, :user_id
    add_index :carts, :variant_id
    add_index :carts, :item_type_id
  end

  def self.down
    drop_table :cart_items
  end
end
