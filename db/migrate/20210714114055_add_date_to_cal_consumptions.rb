class AddDateToCalConsumptions < ActiveRecord::Migration[5.2]
  def change
    add_column :cal_consumptions, :date, :datetime
  end
end
