class DataController < ApplicationController
  def index
    @cal_consumption = current_user.cal_consumptions
    @cal_ingestion = current_user.cal_ingestions
    @cal_ingestions = current_user.cal_ingestions.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) #1週間のカロリー摂取量を定義
    @cal_consumptions = current_user.cal_consumptions.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) #1週間のカロリー消費量を定義
    @cal_ingestions_month = current_user.cal_ingestions.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day) #1か月のカロリー摂取量を定義
  end
  

end
