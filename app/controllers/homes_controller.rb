class HomesController < ApplicationController
  def top
    @user = current_user
  end

  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.name_kana ="ゲスト"
      user.height = 175.5
      user.weight = 70.0
      user.age = 20
      user.sex = "男性"
    end
    sign_in user
    redirect_to cal_balances_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
