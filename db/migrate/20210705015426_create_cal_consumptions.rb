class CreateCalConsumptions < ActiveRecord::Migration[5.2]
  def change
    create_table :cal_consumptions do |t|
      t.integer :cal_consumption
      t.integer :base_cal_consumption
      t.integer :action_pattern
      t.integer :user_id

      t.timestamps
    end
  end
end
