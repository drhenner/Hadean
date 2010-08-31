class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.decimal :price
      t.decimal :total
      t.integer :order_id
      t.integer :variant_id
      t.string :state
      t.integer :tax_rate_id
      t.integer :ship_rate_id

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
