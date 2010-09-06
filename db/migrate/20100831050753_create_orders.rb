class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :number
      t.string :ip_address
      t.string :email
      t.string :state
      t.integer :user_id
      t.integer :bill_address_id
      t.integer :ship_address_id
      t.integer :coupon_id
      t.boolean :active, :default => true, :null => false

      t.timestamps
    end
    
    add_index :orders, :user_id
    add_index :orders, :bill_address_id
    add_index :orders, :ship_address_id
  end

  def self.down
    drop_table :orders
  end
end
