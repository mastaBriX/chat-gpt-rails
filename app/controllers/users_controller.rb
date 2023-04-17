class UsersController < ApplicationController
  def home
  end

  def new
    @user = User.new
  end

  def json
    render :json => User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:user_name] = @user.username.downcase!
      redirect_to root_path, notice: '创建成功！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :password_confirmation)
  end
end