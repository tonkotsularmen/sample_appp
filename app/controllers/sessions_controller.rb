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
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
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

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url#root_pathでもいい。慣習的にはroot_url
  end

end
