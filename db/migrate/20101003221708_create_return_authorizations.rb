class CreateReturnAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :return_authorizations do |t|
      t.string :number
      t.decimal :amount
      t.decimal :restocking_fee
      t.integer :order_id
      t.integer :user_id
      t.string :state
      t.integer :created_by
      t.boolean :active, :default => true
      
      t.timestamps
    end
    add_index :return_authorizations, :number
    add_index :return_authorizations, :order_id
    add_index :return_authorizations, :user_id
    add_index :return_authorizations, :created_by
  end

  def self.down
    drop_table :return_authorizations
  end
end
