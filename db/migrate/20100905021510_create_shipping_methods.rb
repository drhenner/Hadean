class CreateShippingMethods < ActiveRecord::Migration
  def self.up
    create_table :shipping_methods do |t|
      t.string :name
      t.integer :shipping_zone_id

      t.timestamps
    end
    add_index :shipping_methods, :shipping_zone_id
  end

  def self.down
    drop_table :shipping_methods
  end
end
