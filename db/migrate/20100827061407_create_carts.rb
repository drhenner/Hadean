class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :carts, :user_id
  end

  def self.down
    drop_table :carts
  end
end
