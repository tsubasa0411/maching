# frozen_string_literal: true

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
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
