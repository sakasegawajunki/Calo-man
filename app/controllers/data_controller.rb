class DataController < ApplicationController
    before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可する
  def index
    @cal_consumption = current_user.cal_consumptions
    @cal_ingestion = current_user.cal_ingestions
    @cal_ingestions = current_user.cal_ingestions.where(date: Time.now.all_week) #1週間のカロリー摂取量を定義
    @cal_consumptions = current_user.cal_consumptions.where(date: Time.now.all_week) #1週間のカロリー消費量を定義

    this_day = Date.today
   # 今週の日曜日のデータ
    this_sunday  = this_day - (this_day.wday)
    @cal_ingestion_sun = @cal_ingestion.where(date: this_sunday  ).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_sun = @cal_consumption.where(date: this_sunday  ).sum("base_cal_consumption + cal_consumption")
    @cal_balance_sun = @cal_ingestion_sun - @cal_consumption_sun

    # 今週の月曜日のデータ
    this_monday = this_day - (this_day.wday - 1)
    @cal_ingestion_mon = @cal_ingestion.where(date: this_monday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_mon = @cal_consumption.where(date: this_monday).sum("base_cal_consumption + cal_consumption")
    @cal_balance_mon = @cal_ingestion_mon - @cal_consumption_mon

    # 今週の火曜日のデータ
    this_tuesday = this_day - (this_day.wday - 2)
    @cal_ingestion_tue = @cal_ingestion.where(date: this_tuesday).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_tue = @cal_consumption.where(date: this_tuesday).sum("base_cal_consumption + cal_consumption")
    @cal_balance_tue = @cal_ingestion_tue - @cal_consumption_tue
    # 今週の水曜日のデータ
    this_wednesday = this_day - (this_day.wday - 3)
    @cal_ingestion_wed = @cal_ingestion.where(date: this_wednesday ).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_wed = @cal_consumption.where(date: this_wednesday ).sum("base_cal_consumption + cal_consumption")
    @cal_balance_wed = @cal_ingestion_wed - @cal_consumption_wed

   # 今週の木曜日のデータ
    this_thursday  = this_day - (this_day.wday - 4)
    @cal_ingestion_thu = @cal_ingestion.where(date: this_thursday  ).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_thu = @cal_consumption.where(date: this_thursday  ).sum("base_cal_consumption + cal_consumption")
    @cal_balance_thu = @cal_ingestion_thu - @cal_consumption_thu

   # 今週の金曜日のデータ
    this_friday  = this_day - (this_day.wday - 5)
    @cal_ingestion_fri = @cal_ingestion.where(date: this_friday  ).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_fri = @cal_consumption.where(date: this_friday  ).sum("base_cal_consumption + cal_consumption")
    @cal_balance_fri = @cal_ingestion_fri - @cal_consumption_fri

   # 今週の土曜日のデータ
    this_saturday  = this_day - (this_day.wday - 6)
    @cal_ingestion_sat = @cal_ingestion.where(date: this_saturday  ).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal")
    @cal_consumption_sat = @cal_consumption.where(date: this_saturday  ).sum("base_cal_consumption + cal_consumption")
    @cal_balance_sat = @cal_ingestion_sat - @cal_consumption_sat

    # 今週のカロリーバランス合計
    @week_sum = @cal_balance_sun + @cal_balance_mon + @cal_balance_tue + @cal_balance_wed + @cal_balance_thu + @cal_balance_fri + @cal_balance_sat

    # 今月のカロリーバランス合計
    @month_sum = @cal_ingestion.where(date: Time.now.all_month).sum("breakfast_cal+ lunch_cal + dinner_cal + snack_cal") -
    CalConsumption.where(user_id: current_user).where(date: Time.now.all_month).sum("cal_consumption + base_cal_consumption")

    #今月の体重増減(理論値)
    @month_sum_weight = (@month_sum/7000.to_f).round(2)

    # ランキング機能
    # @cal_consumption_ranks = CalConsumption.left_joins(:cal_consumptions).group(:id).where(cal_consumptions:{ date: Time.now.all_month}).order("count(cal_consumptions.id)desc").limit(3)
     # (CalConsumption.group(:cal_consumption_id).order('count(cal_consumption_id) desc').limit(3).pluck(:cal_consumption_id))
  # @books = Book.left_joins(:favorites).group(:id).where(favorites: { created_at: from...to}).order('count(books.id) desc').limit(10)
    c = CalConsumption.arel_table
    cal_consumption_ranks = CalConsumption.select([:id, :date, c[:base_cal_consumption].sum.as('total_base_cal_consumption'), c[:cal_consumption].sum.as('total_cal_consumption')]).where(date: Time.now.all_month).group(:id)
    hash = {}
    cal_consumption_ranks.each do |cal_consumption|
      total = cal_consumption.total_base_cal_consumption + cal_consumption.total_cal_consumption
      hash.store(total, [cal_consumption.id, cal_consumption.date])
    end
    @cal_consumption_rank = hash.sort.reverse.take(3)
  end

end
