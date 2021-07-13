class DataController < ApplicationController
  def index
    @cal_consumption = current_user.cal_consumptions
    @cal_ingestion = current_user.cal_ingestions
    @cal_ingestions = current_user.cal_ingestions.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) #1週間のカロリー摂取量を定義
    @cal_consumptions = current_user.cal_consumptions.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) #1週間のカロリー消費量を定義
    @cal_ingestions_month = current_user.cal_ingestions.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day) #1か月のカロリー摂取量を定義


    @cal_ingestions_week = ["","","","","","",""]
    @cal_ingestions.each do |cal_ingestion|
      @cal_ingestions_week[cal_ingestion.created_at.wday] = cal_ingestion.total_cal_ingestions
    end


    @cal_consumptions_week = ["","","","","","",""]
    @cal_consumptions.each do |cal_consumption|
      @cal_consumptions_week[cal_consumption.created_at.wday] = cal_consumption.total_cal_consumptions
    end


    @cal_balances_week = ["","","","","","",""]
    7.times do |i|
      if !@cal_ingestions_week[i].eql?("") || !@cal_consumptions_week[i].eql?("")
        balance = (@cal_ingestions_week[i].eql?("") ? 0 : @cal_ingestions_week[i].to_i) - (@cal_consumptions_week[i].eql?("") ? 0 : @cal_consumptions_week[i].to_i)
        @cal_balances_week[i] = balance
      end
    end


  end


end
