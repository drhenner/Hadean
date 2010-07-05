class CreatePrototypeProperties < ActiveRecord::Migration
  def self.up
    create_table :prototype_properties do |t|
      t.integer 'prototype_id'
      t.integer 'property_id'
    end
  end

  def self.down
    drop_table :prototype_properties
  end
end
