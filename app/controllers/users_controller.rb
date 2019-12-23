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
    def edit
      @user = User.find(params[:id])
    end
    
    def update
      @user = User.find(params[:id])
      if current_user == @user
        if @user.update(user_params)
          flash[:success] = '編集しました'
          redirect_to @user
        else
        flash.now[:denger] = "編集に失敗しました"
        render :edit
        end
      else
        redirect_to ("/")
      end

    end
    private
    
    def user_params
      params.require(:user).permit(:avatar,
                                    :nickname, 
                                    :email,
                                    :profile, 
                                    :password, 
                                    :password_confirmation)
    end
  end
  

