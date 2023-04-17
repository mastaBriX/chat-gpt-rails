class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:user_name] = user.username

      redirect_to root_path # 或您希望重定向到的其他页面
    else
      flash.now[:danger] = '无效的邮箱或密码'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:user_name)
    redirect_to root_path, method: :get
  end


  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
