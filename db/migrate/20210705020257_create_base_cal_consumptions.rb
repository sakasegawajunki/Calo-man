class CreateBaseCalConsumptions < ActiveRecord::Migration[5.2]
  def change
    create_table :base_cal_consumptions do |t|
      t.integer :cal_consumtion
      t.integer :sex
      t.integer :age
      t.integer :action_pattern

      t.timestamps
    end
  end
end
