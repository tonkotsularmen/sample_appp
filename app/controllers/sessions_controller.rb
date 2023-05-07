class SessionsController < ApplicationController
  # GET /login
  def new
    # x @session = Session.new => Sessionモデル作ってない、データベースを使うほどではないので
    # o scope: :session + url: login_path
  end

  # POST /login
  def create #この情報があれば何かできそうっていうものでやっていく
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Success
      log_in user
      redirect_to user
    else
      # Failure
      # alert-danger => 赤色のフラッシュ
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
      # redirect_to vs. render
      # GET /users/1 => show template
      #              => render 'new'(0回目)
    end
  end
end
