class CreatePrototypeProperties < ActiveRecord::Migration
  def self.up
    create_table :prototype_properties do |t|
      t.integer 'prototype_id', :null => false
      t.integer 'property_id', :null => false
    end
    if SETTINGS[:use_foreign_keys]
      execute "alter table prototype_properties add constraint fk_prototype_properties_prototypes foreign key (prototype_id) references prototypes(id)"
      execute "alter table prototype_properties add constraint fk_prototype_properties_properties foreign key (property_id) references properties(id)"
    end
  end

  def self.down
    if SETTINGS[:use_foreign_keys]
      execute "alter table prototype_properties drop foreign key fk_prototype_properties_prototypes"
      execute "alter table prototype_properties drop foreign key fk_prototype_properties_properties"
    end
    drop_table :prototype_properties
  end
end
