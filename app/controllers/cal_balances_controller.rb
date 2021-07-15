class CalBalancesController < ApplicationController
    before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可する
  def index
    @created_date = params[:created_date].blank? ? Date.today : Date.parse(params[:created_date])#データが空の場合はtodayのページを表示する
    @cal_consumption = CalConsumption.find_by(date: @created_date..@created_date.end_of_day, user_id: current_user.id)
    @cal_ingestion = CalIngestion.find_by(date: @created_date..@created_date.end_of_day, user_id: current_user.id)
  end

end
