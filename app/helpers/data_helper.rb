module DataHelper
  def week_total_cal_balances
    @cal_ingestion.find_by(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)&.total_cal_ingestions.to_i- @cal_consumption.find_by(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)&.total_cal_consumptions.to_i
  end
end
