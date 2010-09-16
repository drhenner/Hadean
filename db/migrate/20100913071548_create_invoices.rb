class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :order_id,  :null => false
      t.string :number,     :null => false
      t.decimal :amount,      :precision => 8, :scale => 2,  :null => false
      #t.boolean :settled,     :default => false,  :null => false
      t.string  :state,  :null => false
      t.boolean :active,      :default => true,   :null => false

      t.timestamps
    end
    add_index :invoices, :order_id
  end

  def self.down
    drop_table :invoices
  end
end
