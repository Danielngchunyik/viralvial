require 'pry'
class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    if @user = login_from(auth_params[:provider])
      redirect_to root_path, notice: "Logged in from #{auth_params[:provider].titleize}!"
    else
      begin
        @user = create_from(auth_params[:provider])
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "Logged in from #{auth_params[:provider].titleize}!"
      rescue
        redirect_to root_path, alert: "Failed to login from #{auth_params[:provider].titleize}"
      end
    end
  end

  private
    def auth_params
      params.permit(:code, :provider)
    end
end
