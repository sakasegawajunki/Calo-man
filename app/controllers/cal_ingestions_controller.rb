class CalIngestionsController < ApplicationController
  def new
    @cal_ingestion = CalIngestion.new
  end
  
  def create
    @cal_ingestion = CalIngestion.new(cal_ingestion_params)
    @cal_ingestion.save
    redirect_back(fallback_location: root_path)
  end

  def edit
  end
  
  private
  
  def cal_ingestion_params
    params.require(:cal_ingestion).permit(:breakfast_cal, :lunch_cal, :dinner_cal, :snack_cal)
  end
end
