class CreatePrototypePropertiesProductTypes < ActiveRecord::Migration
  def self.up
    create_table :prototype_properties_product_types do |t|
      t.integer   :prototype_property_id
      t.integer   :product_type_id
    end
  end

  def self.down
    drop_table :prototype_properties_product_types
  end
end
