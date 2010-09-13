class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :invoice_id
      t.string :confirmation_id
      t.string :error
      t.string :error_code
      t.string :error_message

      t.timestamps
    end
    add_index :payments, :invoice_id
  end

  def self.down
    drop_table :payments
  end
end
