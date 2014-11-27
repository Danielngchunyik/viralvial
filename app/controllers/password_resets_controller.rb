class PasswordResetsController < ApplicationController
  before_action :set_token, only: [:edit, :update]

  def create
    @user = User.find_by_email(params[:email])

    if @user
      @user.deliver_reset_password_instructions!
      flash[:notice] = 'Instructions have been sent to your email.'
    else
      flash[:notice] = 'User not found!'
    end
    redirect_to root_url
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])

    return not_authenticated if @user.blank?
  end

  def update
    @user = User.load_from_reset_password_token(params[:id])
    @user.password_confirmation = params[:user][:password_confirmation]

    return not_authenticated if @user.blank?
    
    if @user.change_password!(params[:user][:password])
      flash[:notice] = 'Password was successfully updated.'
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def set_token
    @token = params[:id]
  end
end
