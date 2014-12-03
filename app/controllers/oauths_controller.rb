class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    if @user = login_from(auth_params[:provider])
      binding.pry
      get_access_token
      flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
    else
      begin
        @user = create_from(auth_params[:provider])
        reset_session
        get_access_token
        auto_login(@user)
        flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
      rescue
        flash[:alert] = "Failed to login from #{auth_params[:provider].titleize}"
      end
    end
    redirect_to root_url
  end

  private

  def get_access_token
    @token = @access_token.token
    @auth = @user.authentications.find_by(provider: params[:provider])
    @auth.update(token: @token)
  end

  def auth_params
    params.permit(:code, :provider)
  end
end
