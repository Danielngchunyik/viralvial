class OauthsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :get_user_location, only: [:callback]

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if @user = login_from(provider)

      set_access_token(@user)
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
    allowed_platforms = ["facebook", "twitter"]

    return redirect_to root_path unless allowed_platforms.include?(provider)
    klass = "Oauth::Retrieve#{provider.capitalize}UserInfo".constantize

    @user = klass.new(@access_token, @country).save

    reset_session

    auto_login(@user)
    flash[:notice] = "You've registered through #{provider.titleize}!"
    redirect_to user_path(current_user)
  end

  def link_account(provider)
    if current_user.authentications.find_by(provider: provider).blank? && @user = add_provider_to_user(provider)
      flash[:notice] = "You have successfully linked your #{provider.titleize} account."
    else
      flash[:error] = "There was a problem linking your #{provider.titleize} account."
    end

    set_access_token(current_user)
    redirect_to user_path(current_user)
  end

  def set_access_token(user)
    case params[:provider]
    when "facebook"
      user.set_access_token(@access_token.token, params[:provider])
    when "twitter"
      user.set_access_token(@access_token.params[:oauth_token], params[:provider], @access_token.params[:oauth_token_secret])
    end
  end

  def get_user_location
    @country = GeoIP.new('db/geoip/GeoIP-city.dat').country(request.remote_ip).try(:country_name) || "Malaysia"
  end
end
