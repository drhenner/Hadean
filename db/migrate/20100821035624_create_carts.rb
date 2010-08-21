class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.integer :variant_id
      t.boolean :active
      t.integer :item_type_id

      t.timestamps
    end
    
    add_index :carts, :user_id
    add_index :carts, :variant_id
    add_index :carts, :item_type_id
  end

  def self.down
    drop_table :carts
  end
end
