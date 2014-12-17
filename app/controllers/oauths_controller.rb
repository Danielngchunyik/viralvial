require 'pry'
class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback

    provider = auth_params[:provider]

    if @user = login_from(provider)

      set_access_token!
      flash[:notice] = "Logged in from #{provider.titleize}!"
      redirect_to root_path
    else

      if logged_in?
        link_account(provider)
        redirect_to user_path(@user)
      else
        begin
          
          @user = create_and_validate_from(provider)

          case provider
          when "twitter"
            finish_signup_path(@user)

          when "facebook"
            reset_session
            set_access_token!
            Oauth::FacebookRegistration.new(@access_token.token, @user).save

          end
            auto_login(@user)
            flash[:notice] = "Logged in from #{provider.titleize}!"
            redirect_to user_path(@user)
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
    case params[:provider]
    when "facebook"
      @user.set_access_token(@access_token.token, nil, params[:provider])
    when "twitter"
      @user.set_access_token(@access_token.params[:oauth_token], @access_token.params[:oauth_token_secret], params[:provider])
    end
  end
end
