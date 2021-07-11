class CalBalancesController < ApplicationController
  def index
    @cal_consumption = current_user.cal_consumptions.created_today.first
    @cal_ingestion = current_user.cal_ingestions.created_today.first
  end
  
  # def search
  #   @cal_ingection = current_user.cal_ingections.where("created_at >= ?", Time.zone.now.beginning_of_day).first
  # end

end 
