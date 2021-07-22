class CalIngestionOnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_null :cal_ingestions, :breakfast_cal, false
    change_column_null :cal_ingestions, :lunch_cal, false
    change_column_null :cal_ingestions, :dinner_cal, false
    change_column_null :cal_ingestions, :snack_cal, false
    change_column_default :cal_ingestions, :breakfast_cal, from: nil, to: 0
    change_column_default :cal_ingestions, :lunch_cal, from: nil, to: 0
    change_column_default :cal_ingestions, :dinner_cal, from: nil, to: 0
    change_column_default :cal_ingestions, :snack_cal, from: nil, to: 0
  end
end
