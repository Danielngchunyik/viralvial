class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    if @user = login_from(auth_params[:provider])
      flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
      redirect_to root_path
    else
      begin
        @user = create_from(auth_params[:provider])
        reset_session
        auto_login(@user)
        flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
        redirect_to root_path
      rescue
        flash[:alert] = "Failed to login from #{auth_params[:provider].titleize}"
        redirect_to root_path      
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
