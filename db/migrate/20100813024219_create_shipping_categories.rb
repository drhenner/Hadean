class CreateShippingCategories < ActiveRecord::Migration
  def self.up
    create_table :shipping_categories do |t|
      t.string :name, :null => false,   :unique => true
      #t.timestamps
    end
  end

  def self.down
    drop_table :shipping_categories
  end
end
