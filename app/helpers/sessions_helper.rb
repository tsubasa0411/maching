module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
   # ログイン時のみ呼び出している
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

　# ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    # current_user.present?の書き方でも良い
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
   #　念のため、ここで下記インスタンス変数をnilにしている
    @current_user = nil
  end
end
