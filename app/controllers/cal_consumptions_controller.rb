class CalConsumptionsController < ApplicationController
  def new
   # @cal_consumtion = CalConsumption.new
  end
  
  def create
    @cal_consumtion = CalConsumption.new(cal_consumtion_params)
    @cal_consumtion.save
    redirect_back(fallback_location: root_path) #画面遷移しない
  end
  
  def edit
    @cal_consumtion = CalConsumption.find(params[:id])
  end
  
  def update
    @cal_consumtion = CalConsumption.find(params[:id])
    @cal_consumtion.update(cal_consumtion_prams)
    redirect_to cal_balance_path
  end

  private
  
  def cal_consumtion_params
    params.require(:cal_consumtion).permit(:cal_consumtion)
  end
end
