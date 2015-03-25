class OauthsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :get_user_location, only: [:callback]

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if @user = login_from(provider)

      @user.set_access_token(@access_token, params[:provider])
      flash[:success] = "You're logged in from #{provider.titleize}!"
      redirect_to user_path(current_user)
    else
      
      if logged_in?
        link_account(provider)

      else
        register_new_user(provider)
      end
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

    check_provider(provider, root_path)

    @user = @klass.new(@access_token, @country).save
    @user.set_access_token(@access_token, params[:provider])

    reset_session

    auto_login(@user)
    flash[:notice] = "You've registered through #{provider.titleize}!"
    redirect_to user_path(current_user)
  end

  def link_account(provider)
    
    check_provider(provider, user_path(current_user))

    if current_user.authentications.find_by(provider: provider).blank? && add_provider_to_user(provider)
      @klass.new(@access_token, nil, current_user).update_followers

      current_user.set_access_token(@access_token, params[:provider])    
      flash[:notice] = "You have successfully linked your #{provider.titleize} account."
    end

    redirect_to user_path(current_user)
  end

  def check_provider(provider, path)
    allowed_platforms = ["facebook", "twitter"]

    return redirect_to path unless allowed_platforms.include?(provider)

    @klass = "Oauth::Retrieve#{provider.capitalize}UserInfo".constantize
  end

  def get_user_location
    @country = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip).try(:country_name) || "Malaysia"
  end
end
