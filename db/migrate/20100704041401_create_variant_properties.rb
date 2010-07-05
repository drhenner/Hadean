class CreateVariantProperties < ActiveRecord::Migration
  def self.up
    create_table :variant_properties do |t|
      t.integer       :variant_id
      t.integer       :property_id
      t.string        :description
    end
  end

  def self.down
    drop_table :variant_properties
  end
end
