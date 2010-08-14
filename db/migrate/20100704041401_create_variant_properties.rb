class CreateVariantProperties < ActiveRecord::Migration
  def self.up
    create_table :variant_properties do |t|
      t.integer       :variant_id, :null => false
      t.integer       :property_id, :null => false
      t.string        :description, :null => false
    end
    if SETTINGS[:use_foreign_keys]
      execute "alter table variant_properties add constraint fk_variant_properties_variants foreign key (variant_id) references variants(id)"
      execute "alter table variant_properties add constraint fk_variant_properties_properties foreign key (property_id) references properties(id)"
    end
  end

  def self.down
    if SETTINGS[:use_foreign_keys]
      execute "alter table variant_properties drop foreign key fk_variant_properties_variants"
      execute "alter table variant_properties drop foreign key fk_variant_properties_properties"
    end
    drop_table :variant_properties
  end
end
