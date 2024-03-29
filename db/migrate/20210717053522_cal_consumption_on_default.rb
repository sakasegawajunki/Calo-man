class CalConsumptionOnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_null :cal_consumptions, :cal_consumption, false
    change_column_null :cal_consumptions, :base_cal_consumption, false
    change_column_default :cal_consumptions, :cal_consumption, from: nil, to: 0
    change_column_default :cal_consumptions, :base_cal_consumption, from: nil, to: 0
  end
end
