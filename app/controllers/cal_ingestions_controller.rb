class CalIngestionsController < ApplicationController
  def new
    @cal_ingestion = CalIngestion.new
  end

  def create
    @cal_ingestion = current_user.cal_ingestions.new(cal_ingestion_params)
    @cal_ingestion.save
    redirect_to cal_balances_path
  end

  def edit
    @cal_ingestion = CalIngestion.find(params[:id])
  end

  def update
    @cal_ingestion = CalIngestion.find(params[:id])
    @cal_ingestion.update(cal_ingestion_params)
    redirect_to cal_balances_path
  end

  private

  def cal_ingestion_params
    params.require(:cal_ingestion).permit(:breakfast_cal, :lunch_cal, :dinner_cal, :snack_cal)
  end
end
