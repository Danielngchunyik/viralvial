class OauthsController < ApplicationController

  before_action :require_login, only: [:destroy]
  before_action :get_user_location, only: [:callback]

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = login_from(provider) || current_user
    auth = Users::Authentication.new(provider, @access_token, @user, @country)

    # Link or Log In User Social Network Accounts
    if logged_in?
      add_provider_to_user(provider) unless @user.authentications.find_by(provider: provider)
      auth.update_logged_in_user

      flash[:notice] = "You have successfully logged in with your #{provider.titleize} account."

    # Register New User
    else
      new_user = auth.register_new_user

      reset_session
      auto_login(new_user)

      flash[:notice] = "You've registered through #{provider.titleize}!"
    end

    redirect_to user_path(current_user)
  end

  def destroy
    provider = params[:provider]
    authentication = current_user.authentications.find_by(provider: provider)

    if authentication.present?
      authentication.destroy
      current_user.social_score.update_followers
      flash[:notice] = "You have successfully unlinked your #{provider.titleize} account."
    else
      flash[:error] = "You do not currently have a linked #{provider.titleize} account."
    end

    redirect_to user_path(current_user)
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def get_user_location
    @country = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip).try(:country_name) || "Malaysia"
  end
end
