class OauthsController < ApplicationController
  include Users::Authentication

  before_action :require_login, only: [:destroy]
  before_action :get_user_location, only: [:callback]

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    # Refer to Authentications module
    if @user = login_from(provider)
      update_logged_in_user(provider)
    else
      # logged_in? is a sorcery gem method
      logged_in? ? link_account(provider) : register_new_user(provider)
    end
  end

  def destroy
    provider = params[:provider]

    unlink_account(provider)
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def get_user_location
    @country = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip).try(:country_name) || "Malaysia"
  end
end
