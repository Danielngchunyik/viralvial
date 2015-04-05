class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = 'Login successful'
      if @user.admin?
        redirect_to admin_dashboard_path
      else 
        redirect_back_or_to root_path
      end
    else
      flash[:error] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = "You've successfully logged out!"
    redirect_to root_path
  end
end
