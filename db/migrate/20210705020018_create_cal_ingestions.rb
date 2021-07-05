class CreateCalIngestions < ActiveRecord::Migration[5.2]
  def change
    create_table :cal_ingestions do |t|
      t.integer :breakfast_cal
      t.integer :lunch_cal
      t.integer :dinner_cal
      t.integer :snack_cal

      t.timestamps
    end
  end
end
