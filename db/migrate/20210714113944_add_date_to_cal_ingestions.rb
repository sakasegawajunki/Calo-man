class AddDateToCalIngestions < ActiveRecord::Migration[5.2]
  def change
    add_column :cal_ingestions, :date, :datetime
  end
end
