class ChangeDatatypeDateOfCalIngestions < ActiveRecord::Migration[5.2]
  def change
    change_column :cal_ingestions, :date, :date
  end
end
