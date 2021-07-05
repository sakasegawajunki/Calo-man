class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
    .permit(:sign_up, keys: [:name, :nama_kana, :profile_image_id, :sex, :age, :height, :weight, :bmi, :introduction])
  end
end
