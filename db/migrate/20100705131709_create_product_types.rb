class CreateProductTypes < ActiveRecord::Migration
  def self.up
    create_table :product_types do |t|
      
      t.string    :name, :null => false
      t.integer   :parent_id
      t.boolean   :active, :default => true
    end
  end

  def self.down
    drop_table :product_types
  end
end
