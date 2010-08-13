class CreateProductProperties < ActiveRecord::Migration
  def self.up
    create_table :product_properties do |t|
      t.integer     :product_id, :null => false
      t.integer     :property_id, :null => false
      t.integer     :position
      t.string      :description, :null => false
    end
  end

  def self.down
    drop_table :product_properties
  end
end
