class DataController < ApplicationController
  before_action :authenticate_user! # ログイン済ユーザーのみにアクセスを許可する
  def index
    @cal_consumption = current_user.cal_consumptions
    @cal_ingestion = current_user.cal_ingestions
    @cal_ingestions = current_user.cal_ingestions.where(date: Time.now.all_week) # 1週間のカロリー摂取量を定義
    @cal_consumptions = current_user.cal_consumptions.where(date: Time.now.all_week) # 1週間のカロリー消費量を定義

    this_day = Date.today
    # 今週の日曜日のデータ
    this_sunday = this_day - this_day.wday
    @cal_ingestion_sun = @cal_ingestion.where(date: this_sunday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_sun = @cal_consumption.where(date: this_sunday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_sun = @cal_ingestion_sun - @cal_consumption_sun#カロリーバランス合計

    # 今週の月曜日のデータ
    this_monday = this_day - (this_day.wday - 1)
    @cal_ingestion_mon = @cal_ingestion.where(date: this_monday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_mon = @cal_consumption.where(date: this_monday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_mon = @cal_ingestion_mon - @cal_consumption_mon#カロリーバランス合計

    # 今週の火曜日のデータ
    this_tuesday = this_day - (this_day.wday - 2)
    @cal_ingestion_tue = @cal_ingestion.where(date: this_tuesday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_tue = @cal_consumption.where(date: this_tuesday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_tue = @cal_ingestion_tue - @cal_consumption_tue#カロリーバランス合計
    # 今週の水曜日のデータ
    this_wednesday = this_day - (this_day.wday - 3)
    @cal_ingestion_wed = @cal_ingestion.where(date: this_wednesday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_wed = @cal_consumption.where(date: this_wednesday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_wed = @cal_ingestion_wed - @cal_consumption_wed#カロリーバランス合計

    # 今週の木曜日のデータ
    this_thursday = this_day - (this_day.wday - 4)
    @cal_ingestion_thu = @cal_ingestion.where(date: this_thursday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_thu = @cal_consumption.where(date: this_thursday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_thu = @cal_ingestion_thu - @cal_consumption_thu#カロリーバランス合計

    # 今週の金曜日のデータ
    this_friday = this_day - (this_day.wday - 5)
    @cal_ingestion_fri = @cal_ingestion.where(date: this_friday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_fri = @cal_consumption.where(date: this_friday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_fri = @cal_ingestion_fri - @cal_consumption_fri#カロリーバランス合計

    # 今週の土曜日のデータ
    this_saturday = this_day - (this_day.wday - 6)
    @cal_ingestion_sat = @cal_ingestion.where(date: this_saturday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
    @cal_consumption_sat = @cal_consumption.where(date: this_saturday).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
    @cal_balance_sat = @cal_ingestion_sat - @cal_consumption_sat#カロリーバランス合計

    # 今週のカロリーバランス合計
    @week_sum = @cal_balance_sun + @cal_balance_mon + @cal_balance_tue + @cal_balance_wed + @cal_balance_thu + @cal_balance_fri + @cal_balance_sat

    # 今月のカロリーバランス合計
    @month_sum = @cal_ingestion.where(date: Time.now.all_month).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal") -
    CalConsumption.where(user_id: current_user).where(date: Time.now.all_month).sum("cal_consumption + base_cal_consumption")

    # 今月の体重増減(理論値)
    @week_sum_weight = (@week_sum / 7000.to_f).round(2)

    # 今月の体重増減(理論値)
    @month_sum_weight = (@month_sum / 7000.to_f).round(2)

    # ランキング機能(消費カロリー)
    cal_consumption_ranks = CalConsumption.select([:id, :date, :base_cal_consumption, :cal_consumption]).where(date: Time.now.all_month).where(user_id: current_user.id)
    hash = {}
    cal_consumption_ranks.each do |cal_consumption|
      total_cal_consumptions = cal_consumption.base_cal_consumption + cal_consumption.cal_consumption # 条件に合う各レコードの合計
      hash.store(total_cal_consumptions, [cal_consumption.id, cal_consumption.date]) # hashに指定したカラムを入れる
    end
    @cal_consumption_rank = hash.sort.reverse.take(3) # 降順で上位3位まで取得する

    # ランキング機能(摂取カロリー)
    cal_ingestion_ranks = CalIngestion.select([:id, :date, :breakfast_cal, :lunch_cal, :dinner_cal, :snack_cal]).where(date: Time.now.all_month).where(user_id: current_user.id)
    hash = {}
    cal_ingestion_ranks.each do |cal_ingestion|
      total_cal_ingestions = cal_ingestion.breakfast_cal + cal_ingestion.lunch_cal + cal_ingestion.dinner_cal + cal_ingestion.snack_cal# 条件に合う各レコードの合計
      hash.store(total_cal_ingestions, [cal_ingestion.id, cal_ingestion.date])# hashに指定したカラムを入れる
    end
    @cal_ingestion_rank = hash.sort.reverse.take(3) # 降順で上位3位まで取得する
  end
end
