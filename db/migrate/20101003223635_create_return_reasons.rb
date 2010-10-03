class CreateReturnReasons < ActiveRecord::Migration
  def self.up
    create_table :return_reasons do |t|
      t.string :label
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :return_reasons
  end
end
