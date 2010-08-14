class CreateVariants < ActiveRecord::Migration
  def self.up
    create_table :variants do |t|
      t.integer         :product_id,                                                :null => false
      t.string          :sku,                                                       :null => false,   :unique => true
      t.decimal         :price,     :precision => 8, :scale => 2, :default => 0.0,  :null => false
      t.decimal         :cost,      :precision => 8, :scale => 2, :default => 0.0,  :null => false
      t.datetime        :deleted_at
      t.boolean         :master,    :default => false, :null => false
      t.integer         :count_on_hand,               :default => 0, :null => false
      t.integer         :count_pending_to_customer,   :default => 0, :null => false
      t.integer         :count_pending_from_supplier, :default => 0, :null => false
      t.timestamps
    end
    
    execute "alter table variants add constraint fk_variants_products foreign key (product_id) references products(id)" if SETTINGS[:use_foreign_keys]
  end

  def self.down
    execute "alter table variants drop foreign key fk_variants_products" if SETTINGS[:use_foreign_keys]
    drop_table :variants
  end
end
