class UserSessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = 'Login successful'
      redirect_back_or_to @user
    else
      flash[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:notice] = 'Logged out!'
    redirect_to root_url
  end
end
