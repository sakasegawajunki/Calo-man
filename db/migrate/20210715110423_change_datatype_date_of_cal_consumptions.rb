class ChangeDatatypeDateOfCalConsumptions < ActiveRecord::Migration[5.2]
  def change
    change_column :cal_consumptions, :date, :date 
  end
end
