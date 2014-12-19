class OauthsController < ApplicationController
  before_action :require_login, only: [:destroy]
  def oauth
    login_at(auth_params[:provider])
  end

  def callback

    provider = auth_params[:provider]

    if @user = login_from(provider)

      set_access_token!(@user)
      flash[:notice] = "Logged in from #{provider.titleize}!"
      redirect_to root_path
    else

      if logged_in?
        link_account_set_access_token!(provider)
        
      else
        begin

          @user = create_and_validate_from(provider)
          reset_session
          
          case provider
          when "twitter"
            save_twitter_info!

          when "facebook"
            save_facebook_info!

          end
            auto_login(@user)
            flash[:notice] = "Logged in from #{provider.titleize}!"
            redirect_to edit_user_path(current_user)
        rescue
          flash[:alert] = "Failed to login from #{provider.titleize}"
          redirect_to root_path
        end
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
      flash[:alert] = "You do not currently have a linked #{provider.titleize} account."
    end

    redirect_to user_path(current_user)
  end

  private

  def save_twitter_info!
    set_access_token!(@user)
    Oauth::RetrieveTwitterUserInfo.new(@access_token.token, @access_token.secret, @user, @access_token.params[:screen_name]).save
  end

  def save_facebook_info!
    set_access_token!(@user)
    Oauth::RetrieveFacebookUserInfo.new(@access_token.token, @user).save
  end

  def auth_params
    params.permit(:code, :provider)
  end

  def link_account_set_access_token!(provider)
    if current_user.authentications.find_by(provider: provider).blank? && @user = add_provider_to_user(provider)
      flash[:notice] = "You have successfully linked your #{provider.titleize} account."
    else
      flash[:alert] = "There was a problem linking your #{provider.titleize} account."
    end

    set_access_token!(current_user)
    redirect_to edit_user_path(current_user)
  end

  def set_access_token!(user)
    case params[:provider]
    when "facebook"
      user.set_access_token(@access_token.token, nil, params[:provider])
    when "twitter"
      user.set_access_token(@access_token.params[:oauth_token], @access_token.params[:oauth_token_secret], params[:provider])
    end
  end
end
