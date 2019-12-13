# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].douncase)
    if user && user.authenticate(params[:session][:password])
       # session[:user_id] = user.idをカスタムヘルパーで定義してもの
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
  end

end
