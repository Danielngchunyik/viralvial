class OauthsController < ApplicationController

  def oauth
    login_at(params[:provider])
  end

  def callback
    if @user = login_from(params[:provider])

      set_access_token!
      flash[:notice] = "Logged in from #{params[:provider].titleize}!"
    else
      begin
        @user = create_from(params[:provider])
        reset_session
        
        set_access_token!
        Users::OauthRegistration.new(@access_token.token, @user).save

        auto_login(@user)
        flash[:notice] = "Logged in from #{params[:provider].titleize}!"
      rescue
        flash[:alert] = "Failed to login from #{params[:provider].titleize}"
      end
    end
    redirect_to root_url
  end

  private

  def set_access_token!
    @user.set_access_token(@access_token.token, params[:provider])
  end
end
