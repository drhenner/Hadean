class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string            :name, :null => false
      t.text              :description
      t.integer           :tax_category_id
      t.integer           :shipping_category_id
      t.integer           :product_type_id, :null => false
      t.integer           :prototype_id
      t.datetime          :available_at
      t.datetime          :deleted_at
      t.string            :meta_keywords
      t.string            :meta_description
      #t.integer           :count_on_hand
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
