class CalIngestionsController < ApplicationController
  def new
    @cal_ingestion = CalIngestion.new
  end

  def create
    @cal_ingestion = current_user.cal_ingestions.new(cal_ingestion_params)
    if @cal_ingestion.save
      flash[:notice] = "カロリー摂取量を保存しました。"
      redirect_to cal_balances_path
    else
      flash[:alert] = "正しく入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @cal_ingestion = CalIngestion.find(params[:id])
  end

  def update
    @cal_ingestion = CalIngestion.find(params[:id])
    if @cal_ingestion.update(cal_ingestion_params)
        redirect_to cal_balances_path
      flash[:notice] = "カロリー摂取量を更新しました。"
    else
      flash[:alert] = "正しく入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def cal_ingestion_params
    params.require(:cal_ingestion).permit(:breakfast_cal, :lunch_cal, :dinner_cal, :snack_cal)
  end
end
