class UsersController < ApplicationController
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
    else 
      #Failure
      render 'new'
    end 
  end
  
  private#ここより上はやろうと思えば外側のコントローラからもアクセスできる。ここより下はこのファイルの中でしかアクセスできない。
  
  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
