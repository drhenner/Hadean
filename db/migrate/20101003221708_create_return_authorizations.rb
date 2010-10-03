class CreateReturnAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :return_authorizations do |t|
      t.string :number
      t.decimal :amount
      t.decimal :restocking_fee
      t.integer :order_id
      t.string :state
      t.integer :created_by

      t.timestamps
    end
  end

  def self.down
    drop_table :return_authorizations
  end
end
