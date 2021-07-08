class CalIngestion < ApplicationRecord
  belongs_to :user
  
  def total_cal_ingestions
    breakfast_cal.to_i + lunch_cal.to_i + dinner_cal.to_i + snack_cal.to_i
  end
end
