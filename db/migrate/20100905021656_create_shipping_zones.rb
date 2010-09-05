class CreateShippingZones < ActiveRecord::Migration
  def self.up
    create_table :shipping_zones do |t|
      t.string :name

    end
  end

  def self.down
    drop_table :shipping_zones
  end
end
