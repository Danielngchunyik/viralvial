class OauthsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :get_user_location, only: [:callback]

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if @user = login_from(provider)

      # Run updates on user's followers and access tokens
      @user.set_access_token(@access_token, params[:provider])
      @user.social_score.update_followers

      flash[:success] = "You're logged in from #{provider.titleize}!"
      redirect_to user_path(current_user)
    else
      logged_in? ? link_account(provider) : register_new_user(provider)
    end
  end

  def destroy
    provider = params[:provider]

    authentication = current_user.authentications.find_by(provider: provider)

    if authentication.present?
      authentication.destroy
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

  def register_new_user(provider)

    sanitize_klass(provider)

    @user = @klass.new(@access_token, @country).save
    @user.set_access_token(@access_token, params[:provider])

    reset_session

    auto_login(@user)
    
    flash[:notice] = "You've registered through #{provider.titleize}!"
    redirect_to user_path(current_user)
  end

  def link_account(provider)

    sanitize_klass(provider)
    add_provider_to_user(provider)

    @klass.new(@access_token, nil, current_user).update_followers
    current_user.set_access_token(@access_token, params[:provider])    
    
    flash[:notice] = "You have successfully linked your #{provider.titleize} account."
    redirect_to user_path(current_user)
  end

  def sanitize_klass(provider)
    allowed_klasses = [Oauth::RetrieveFacebookUserInfo, Oauth::RetrieveTwitterUserInfo]

    klass = "Oauth::Retrieve#{provider.capitalize}UserInfo"
    @klass = klass.sanitize_constant(allowed_klasses)
  end

  def get_user_location
    @country = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip).try(:country_name) || "Malaysia"
  end
end
