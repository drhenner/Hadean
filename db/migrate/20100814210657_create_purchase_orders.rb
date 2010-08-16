class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer :supplier_id,       :null => false
      t.string :invoice_number
      t.string :tracking_number
      t.string :notes
      t.string :state
      t.datetime :ordered_at,       :null => false
      t.date :estimated_arrival_on
      #t.boolean :is_received,       :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
