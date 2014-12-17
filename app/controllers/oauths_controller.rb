class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback

    provider = auth_params[:provider]

    if @user = login_from(provider)

      set_access_token!
      flash[:notice] = "Logged in from #{provider.titleize}!"
    else

      if logged_in?
        link_account(provider)
        redirect_to root_path
      else
        begin
          @user = create_from(provider)
          reset_session
          
          set_access_token!
          Users::FacebookOauthRegistration.new(@access_token.token, @user).save

          auto_login(@user)
          flash[:notice] = "Logged in from #{provider.titleize}!"
        rescue
          flash[:alert] = "Failed to login from #{provider.titleize}"
        end
      end
    end
    redirect_to user_path(@user)
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def link_account(provider)
    if @user = add_provider_to_user(provider)
      flash[:notice] = "You have successfully linked your #{provider.titleize} account."
    else
      flash[:alert] = "There was a problem linking your #{provider.titleize} account."
    end
  end

  def set_access_token!
    @user.set_access_token(@access_token.token, params[:provider])
  end
end
