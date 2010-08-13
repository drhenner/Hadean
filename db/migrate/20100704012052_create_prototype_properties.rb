class CreatePrototypeProperties < ActiveRecord::Migration
  def self.up
    create_table :prototype_properties do |t|
      t.integer 'prototype_id', :null => false
      t.integer 'property_id', :null => false
    end
  end

  def self.down
    drop_table :prototype_properties
  end
end
