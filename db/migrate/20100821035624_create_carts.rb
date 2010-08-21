class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id
      t.integer :variant_id
      t.boolean :active
      t.integer :item_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
