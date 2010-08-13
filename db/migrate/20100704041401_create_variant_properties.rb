class CreateVariantProperties < ActiveRecord::Migration
  def self.up
    create_table :variant_properties do |t|
      t.integer       :variant_id, :null => false
      t.integer       :property_id, :null => false
      t.string        :description, :null => false
    end
  end

  def self.down
    drop_table :variant_properties
  end
end
