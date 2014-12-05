class OauthsController < ApplicationController

  def oauth
    login_at(params[:provider])
  end

  def callback
    if user = login_from(params[:provider])
      user.set_access_token(@access_token.token, params[:provider])
      flash[:notice] = "Logged in from #{params[:provider].titleize}!"
    else
      begin
        user = create_from(params[:provider])
        reset_session
        user.set_access_token(@access_token.token, params[:provider])
        user.sync_with_facebook!
        auto_login(user)
        flash[:notice] = "Logged in from #{params[:provider].titleize}!"
      rescue
        flash[:alert] = "Failed to login from #{params[:provider].titleize}"
      end
    end
    redirect_to root_url
  end
end
