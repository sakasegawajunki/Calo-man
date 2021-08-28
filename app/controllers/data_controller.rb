class DataController < ApplicationController
  before_action :authenticate_user! # ログイン済ユーザーのみにアクセスを許可する
  def index
    @cal_consumption = current_user.cal_consumptions
    @cal_ingestion = current_user.cal_ingestions
    @created_date = params[:created_date].blank? ? Date.today : Date.parse(params[:created_date]) # parseメソッドで日付を取得、created_dateが空の場合はtodayを表示する(三項演算子)

    @cal_ingestions = []
    @cal_consumptions = []
    @cal_balances = []
    this_day = Date.today
    (0..6).each do |day|
      target_day = this_day - (this_day.wday - day)
      ingestion = @cal_ingestion.where(date: target_day).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")#摂取カロリー合計
      consumption = @cal_consumption.where(date: target_day).sum("base_cal_consumption + cal_consumption")#消費カロリー合計
      @cal_ingestions << ingestion# =>グラフ作成用の配列
      @cal_consumptions << consumption# =>グラフ作成用の配列
      @cal_balances << (ingestion - consumption)#カロリーバランス合計
    end

    # 今週のカロリーバランス合計
    @week_sum = @cal_balances.sum

    # 今月のカロリーバランス合計
    @month_sum = @cal_ingestion.where(date: Time.now.all_month).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal") -
    @cal_consumption.where(date: Time.now.all_month).sum("cal_consumption + base_cal_consumption")

    # 今月の体重増減(理論値)
    @week_sum_weight = (@week_sum / 7000.to_f).round(2)

    # 今月の体重増減(理論値)
    @month_sum_weight = (@month_sum / 7000.to_f).round(2)

    # ランキング機能(消費カロリー)
    cal_consumption_ranks = CalConsumption.select([:id, :date, :base_cal_consumption, :cal_consumption]).where(date: Time.now.all_month, user_id: current_user.id)#.where(user_id: current_user.id)
    temp = cal_consumption_ranks.map do |cal_consumption| #mapメソッドを使用すると戻り値が配列になる
      total_cal_consumptions = cal_consumption.base_cal_consumption + cal_consumption.cal_consumption # 条件に合う各レコードの合計
      { 'cal' => total_cal_consumptions, 'date' => cal_consumption.date }#配列に要素を追加(キー"cal"対する値total_cal_consumptions,キー"date"対する値cal_consumption.date,)
    end
    @cal_consumption_rank = temp.sort_by{|data| data["cal"]}.reverse.take(3) #"cal"で比較して降順で上位3位まで取得する

    # ランキング機能(摂取カロリー)
    cal_ingestion_ranks = CalIngestion.select([:id, :date, :breakfast_cal, :lunch_cal, :dinner_cal, :snack_cal]).where(date: Time.now.all_month, user_id: current_user.id)#.where(user_id: current_user.id)
    temp = cal_ingestion_ranks.map do |cal_ingestion| #mapメソッドを使用すると戻り値が配列になる
      total_cal_ingestions = cal_ingestion.breakfast_cal + cal_ingestion.lunch_cal + cal_ingestion.dinner_cal + cal_ingestion.snack_cal# 条件に合う各レコードの合計
      { 'cal' => total_cal_ingestions, 'date' => cal_ingestion.date }#配列に要素を追加(キー"cal"対する値total_cal_ingestions,キー"date"対する値cal_ingestion.date)
    end
    @cal_ingestion_rank = temp.sort_by{|data| data['cal'] }.reverse.take(3) # "cal"で比較して降順で上位3位まで取得する
  end
end
