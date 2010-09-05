class CreateShippingRates < ActiveRecord::Migration
  def self.up
    create_table :shipping_rates do |t|
      t.integer :shipping_method_id,  :null => false
      t.decimal :rate,      :precision => 8, :scale => 2, :default => 0.0,  :null => false
      t.integer :shipping_rate_type_id,  :null => false
      t.integer :position
      t.boolean :active,          :default => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_rates
  end
end
