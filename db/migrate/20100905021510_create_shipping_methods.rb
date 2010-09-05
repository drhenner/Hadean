class CreateShippingMethods < ActiveRecord::Migration
  def self.up
    create_table :shipping_methods do |t|
      t.string :name
      t.integer :zone_id

      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_methods
  end
end
