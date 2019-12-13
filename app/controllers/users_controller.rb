class UsersController < ApplicationController
  
    def new
      @user = User.new   
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = 'ユーザー登録をしました'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザー登録に失敗しました'
        render :new
      end
  
    end
    private
    
    def user_params
      params.require(:user).permit(:avatar,
                                    :name, 
                                    :email,
                                    :profile, 
                                    :password, 
                                    :password_confirmation)
    end
  end
  

