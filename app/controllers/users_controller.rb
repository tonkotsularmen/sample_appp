class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/:id GETリクエストが/users/:idに来た時
  def show
    @user = User.find(params[:id])
  end
  # GET /users/new GETリクエストが/users/newに来た時
  def new
    @user = User.new
  end
  # POST /users(+ params)
  def create
    # (user + given params).save
    # User.create(params[:user])
    # => name, email, pass/confirmation
    @user = User.new(user_params)
    if @user.save
      #Success
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1) => /users/1
    else
      #Failure
      render 'new'
    end
  end

  # GET /users/:id/edit
  def edit#PATCHリクエストを送るためのフォームを生成するためのページ
    @user = User.find(params[:id])# => app/views/users/edit.html.erb
  end

  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      #@user.errors <== ここにデータが入っている。ここにデータをセットしたままeditテンプレート呼び出している。
      render 'edit'
    end
  end
  
  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private#ここより上はやろうと思えば外側のコントローラからもアクセスできる。ここより下はこのファイルの中でしかアクセスできない。

    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
         redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user? @user
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
