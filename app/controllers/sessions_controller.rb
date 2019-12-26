class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].douncase)
    if user && user.authenticate(params[:session][:password])
      # session[:user_id] = user.idをカスタムヘルパーで定義してもの
      log_in user
      #　三項演算子で条件分岐処理
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインに成功しました。'
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    logout if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
