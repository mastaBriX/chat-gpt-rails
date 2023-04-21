class AdminController < ApplicationController
  before_action :has_admin
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id].to_i)
    @user.destroy!

    render turbo_stream: turbo_stream.remove("admin-table-record-#{params[:id]}")
  end

end
