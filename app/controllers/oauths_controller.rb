class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    if @user = login_from(auth_params[:provider])
      binding.pry
      flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
    else
      begin
        @user = create_from(auth_params[:provider])
        reset_session
        auto_login(@user)
        flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
      rescue
        flash[:alert] = "Failed to login from #{auth_params[:provider].titleize}"
      end
    end
    redirect_to root_url
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
