class CreateShippingRates < ActiveRecord::Migration
  def self.up
    create_table :shipping_rates do |t|
      t.integer :shipping_method_id
      t.decimal :rate
      t.integer :shipping_rate_type_id
      t.integer :position
      
      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_rates
  end
end
