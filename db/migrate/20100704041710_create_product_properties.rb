class CreateProductProperties < ActiveRecord::Migration
  def self.up
    create_table :product_properties do |t|
      t.integer     :product_id
      t.integer     :property_id
      t.integer     :position
      t.string      :description
    end
  end

  def self.down
    drop_table :product_properties
  end
end
