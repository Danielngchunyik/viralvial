class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.find_by_email(params[:email])

    if @user
      @user.deliver_reset_password_instructions!
      redirect_to(root_path, notice: 'Instructions have been sent to your email.')
    else
      redirect_to(root_path, notice: 'User not found!')
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return not_authenticated if @user.blank?
  end

  def update
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, notice: 'Password was successfully updated.')
    else
      render :edit
    end
  end
end
