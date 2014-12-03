class UsersController < ApplicationController
  before_action :set_user,
                :require_login,
                only: [:show, :edit, :update]

  def show
    authorize @user
  end

  def new
    @user = User.new
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User registered"
      redirect_to root_url
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'new'
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:notice] = "User details updated"
      redirect_to @user
    else
      flash[:error] = "error :#{@user.errors.full_messages}"
      render action: 'edit'
    end
  end

  private

  def set_user  
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :image, authentication_attributes: [])
  end
end
