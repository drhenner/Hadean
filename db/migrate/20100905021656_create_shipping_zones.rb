class CreateShippingZones < ActiveRecord::Migration
  def self.up
    create_table :shipping_zones do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_zones
  end
end
