module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    #DBへの問い合わせの数を可能な限り小さくしたい
    if session[:user_id]
      User.find_by(id: session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
      #
    end
  end

   # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?#current_user.nilは「current_userがnil」?「チェックしている」、！「ではない」
    #=>current_userがnilではないからログインしている
  end
end
