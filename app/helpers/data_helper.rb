module DataHelper
  def this_day
    Date.today
  end

  def week_total_cal_balances
    @cal_ingestion.find_by(created_at: 1.day.ago.all_day)&.total_cal_ingestions.to_i - @cal_consumption.find_by(created_at: 1.day.ago.all_day)&.total_cal_consumptions.to_i + @cal_ingestion.find_by("created_at >= ?", Time.zone.now.beginning_of_day)&.total_cal_ingestions.to_i - @cal_consumption.find_by("created_at >= ?", Time.zone.now.beginning_of_day)&.total_cal_consumptions.to_i
  end

  def month_total_cal_balances
    now = Time.current
    @cal_ingestion.find_by(created_at: now.beginning_of_month..now.end_of_month)&.total_cal_ingestions.to_i - @cal_consumption.find_by(created_at: now.beginning_of_month..now.end_of_month)&.total_cal_consumptions.to_i
  end
end
