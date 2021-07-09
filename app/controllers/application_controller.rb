class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource)
    cal_balances_path
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name, :name_kana, :profile_image, :sex,
      :age, :height, :weight, :bmi, :introduction, :email,])
  end


end
