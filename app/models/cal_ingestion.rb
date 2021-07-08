class CalIngestion < ApplicationRecord
  belongs_to :user
  
  def total_cal_ingestions
   300
    # (breakfast_cal+lunch_cal+dinner_cal+snack_cal)
  end
end
