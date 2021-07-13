class CalBalancesController < ApplicationController
  def index
    # @cal_consumption = current_user.cal_consumptions.created_today.first
    # @cal_ingestion = current_user.cal_ingestions.created_today.first
    created_date = params[:created_date].nil? ? Date.today : Date.parse(params[:created_date]) #params[:created_date]
    @cal_consumption = CalConsumption.find_by(created_at: created_date..created_date.end_of_day, user_id:current_user.id)
    @cal_ingestion = CalIngestion.find_by(created_at: created_date..created_date.end_of_day, user_id:current_user.id)


    # @q = CalBalance.ransack(params[:q])
    # @cal_balance = @q.result(distinct: true)
  end

  # def search
  #   @cal_ingection = current_user.cal_ingections.where("created_at >= ?", Time.zone.now.beginning_of_day).first
  # end

end
