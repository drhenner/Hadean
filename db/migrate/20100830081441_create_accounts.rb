class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :account_type
      t.decimal :monthly_charge
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
