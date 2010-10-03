class CreateReturnItems < ActiveRecord::Migration
  def self.up
    create_table :return_items do |t|
      t.integer :order_item_id
      t.integer :return_condition_id
      t.integer :return_reason
      t.boolean :returned
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :return_items
  end
end
