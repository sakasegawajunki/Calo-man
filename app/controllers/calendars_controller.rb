class CalendarsController < ApplicationController
   before_action :authenticate_user! # ログイン済ユーザーのみにアクセスを許可する
  def index
    @cal_ingestions = current_user.cal_ingestions
    @cal_consumptions = current_user.cal_consumptions
  end
end
