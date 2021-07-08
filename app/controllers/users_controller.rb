class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  
    
  end

  def data
    @user = current_user
    # unless @user != current_user
    # redirect_to user_path(@user.id)
    # end
      
  end

  def edit
    @user = current_user
  end
  
  def update
    user = User.find(params[:id])
    user.assign_attributes(user_params)
    if user.save(validate: false)
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
    @user = current_user
    @users = User.where(is_valid: true).page(params[:page]).per(2)
  end

  def unsubcribe
  end
  
  def withdraw
    @user = current_user
    @user.update(is_valid: false)
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
        :profile_image,
        :introduction,
        :height,
        :weight,
        :bmi,
        :sex,
        :age
        )
    end
end
