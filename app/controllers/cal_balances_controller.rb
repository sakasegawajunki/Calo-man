class CalBalancesController < ApplicationController
  def index
    created_date = params[:created_date].nil? ? Date.today : Date.parse(params[:created_date])#データが空の場合はtodayページを表示する
    @cal_consumption = CalConsumption.find_by(created_at: created_date..created_date.end_of_day, user_id: current_user.id)
    @cal_ingestion = CalIngestion.find_by(created_at: created_date..created_date.end_of_day, user_id: current_user.id)
  end

end
