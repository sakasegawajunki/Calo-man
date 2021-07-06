class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def data
    unless @user != current_user
     redirect_to user_path(user.id)
    end
      
  end

  def edit
    @user = current_user
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = '会員情報の変更を保存しました。'
      redirect_to user_path(user.id)
    else
      @user = user
      flash[:alert] = "正しく入力してください。"
      render :edit
    end
  end

  def index
    #per()で1ページに入れたい数を変更する
    @users = User.page(params[:page]).per(5)
  end

  def unsubcribe
  end
  
  def withdraw
    user = current_user
    user.update(is_valid: false)
    reset_session
    flash[:notice] = 'ありがとうございます。またのご利用をお待ちしております。'
    redirect_to root_path
  end
  
    private
    
    def user_params
      params.require(:user).permit(
        :name,
        :name_kana,
        :password,
        :profile_image_id,
        :introduction,
        :height,
        :weight,
        :bmi,
        :sex,
        :age
        )
    end
end
