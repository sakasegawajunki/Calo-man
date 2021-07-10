class CalConsumptionsController < ApplicationController
  def new
    @cal_consumption = CalConsumption.new
  end

  def create
    @cal_consumption = CalConsumption.new(cal_consumption_params)
    @cal_consumption.base_cal_consumption = @cal_consumption.calcurate_base_cal_consumption(current_user, params[:cal_consumption][:action_pattern].to_i)
    # @cal_consumption.base_cal_consumption = @cal_consumption.calcurate_base_cal_consumption(current_user, cal_consumption_params[:action_pattern])
    @cal_consumption.action_pattern =params[:cal_consumption][:action_pattern].to_i
    @cal_consumption.user = current_user
    @cal_consumption.save
    redirect_to  edit_cal_consumption_path(@cal_consumption.id)
  end

  def edit
    @cal_consumption = CalConsumption.find(params[:id])
    #@base_cal_consumption = BaseCalConsumption.find_by(updated_at: @cal_consumption.updated_at.to_date)
  end

  def update
    @cal_consumption = CalConsumption.find(params[:id])
    @cal_consumption.base_cal_consumption = @cal_consumption.calcurate_base_cal_consumption(current_user, params[:cal_consumption][:action_pattern].to_i)
    @cal_consumption.action_pattern =params[:cal_consumption][:action_pattern].to_i
    @cal_consumption.cal_consumption = params[:cal_consumption][:cal_consumption].to_i
    @cal_consumption.save
    redirect_to cal_balances_path
  end

  private

  def cal_consumption_params
    params.require(:cal_consumption).permit(:cal_consumption)
  end



end
