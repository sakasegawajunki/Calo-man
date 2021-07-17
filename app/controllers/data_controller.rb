class DataController < ApplicationController
    before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可する
  def index
    @cal_consumption = current_user.cal_consumptions
    @cal_ingestion = current_user.cal_ingestions
    @cal_ingestions = current_user.cal_ingestions.where(date: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) #1週間のカロリー摂取量を定義
    @cal_consumptions = current_user.cal_consumptions.where(date: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) #1週間のカロリー消費量を定義
    # @date = Date.today #今日の日付を取得
    # @cal_ingestions_month = current_user.cal_ingestions.where(date: @date.beginning_of_month..@date.end_of_month)#今月のカロリー摂取量を定義

    #今週の摂取カロリー
    @cal_ingestions_week = ["","","","","","",""]
    @cal_ingestions.each do |cal_ingestion|
      @cal_ingestions_week[cal_ingestion.date.wday] = cal_ingestion.total_cal_ingestions
    end

    #今週の消費カロリー
    @cal_consumptions_week = ["","","","","","",""]
    @cal_consumptions.each do |cal_consumption|
      @cal_consumptions_week[cal_consumption.date.wday] = cal_consumption.total_cal_consumptions
    end

    #今週のカロリーバランス
    @cal_balances_week = ["","","","","","",""]
    7.times do |i|
      if !@cal_ingestions_week[i].eql?("") || !@cal_consumptions_week[i].eql?("")
        balance = (@cal_ingestions_week[i].eql?("") ? 0 : @cal_ingestions_week[i].to_i) - (@cal_consumptions_week[i].eql?("") ? 0 : @cal_consumptions_week[i].to_i)
        @cal_balances_week[i] = balance
      end
    end
    # # <!--=====今月のトータルカロリーバランスを計算する=====-->
    @month_sum = @cal_ingestion.where(date: Time.now.all_month).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal") -
    CalConsumption.where(user_id: current_user).where(date: Time.now.all_month).sum("cal_consumption + base_cal_consumption")
    #今月の体重増減(理論値)
    @month_sum_weight = (@month_sum/7000.to_f).round(2)
  end

end
