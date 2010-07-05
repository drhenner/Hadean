class CreateVariants < ActiveRecord::Migration
  def self.up
    create_table :variants do |t|
      t.integer         :product_id
      t.string          :sku
      t.decimal         :price,     :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.decimal         :cost,      :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.datetime        :deleted_at
      t.boolean         :master,    :default => false
      t.integer         :count_on_hand
      t.integer         :count_pending_to_customer
      t.integer         :count_pending_from_supplier
      t.timestamps
    end
  end

  def self.down
    drop_table :variants
  end
end
