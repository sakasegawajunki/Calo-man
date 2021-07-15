class CalConsumptionsController < ApplicationController
    before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可する
  def new
    @cal_consumption = CalConsumption.new
  end

  def create
    @cal_consumption = CalConsumption.new(cal_consumption_params)
    @cal_consumption.base_cal_consumption = @cal_consumption.calcurate_base_cal_consumption(current_user, params[:cal_consumption][:action_pattern].to_i)#行動パターンによる基礎代謝量
    @cal_consumption.action_pattern =params[:cal_consumption][:action_pattern].to_i
    @cal_consumption.user = current_user
    if @cal_consumption.save
      flash[:notice] = "カロリー消費量を保存しました。"
      redirect_to cal_balances_path(created_date: @cal_consumption.date)
    else
      flash[:alert] = "正しく入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @cal_consumption = CalConsumption.find(params[:id])
  end

  def update
    @cal_consumption = CalConsumption.find(params[:id])
    @cal_consumption.base_cal_consumption = @cal_consumption.calcurate_base_cal_consumption(current_user, params[:cal_consumption][:action_pattern].to_i)
    @cal_consumption.action_pattern =params[:cal_consumption][:action_pattern].to_i
    @cal_consumption.cal_consumption = params[:cal_consumption][:cal_consumption].to_i
    if @cal_consumption.save
      flash[:notice] = "カロリー消費量を更新しました。"
      redirect_to cal_balances_path(created_date: @cal_consumption.date)
    else
      flash[:alert] = "正しく入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def cal_consumption_params
    params.require(:cal_consumption).permit(:cal_consumption, :date)
  end



end
