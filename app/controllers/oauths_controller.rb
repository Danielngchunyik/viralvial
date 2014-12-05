class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    if @user = login_from(auth_params[:provider])
      get_access_token
      flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
    else
      begin
        @user = create_from(auth_params[:provider])
        reset_session
        get_access_token
        save_user_details
        auto_login(@user)
        flash[:notice] = "Logged in from #{auth_params[:provider].titleize}!"
      rescue
        flash[:alert] = "Failed to login from #{auth_params[:provider].titleize}"
      end
    end
    redirect_to root_url
  end

  private

  def save_user_details
    fb_user = FbGraph::User.fetch("me?access_token=#{@token}")
    @user.remote_image_url = "#{fb_user.picture}?redirect=1&height=300&type=normal&width=300"
    location_array = fb_user.location.name.split(', ')
    @user.update(birthday: fb_user.birthday, location: location_array[0], country: IsoCountryCodes.search_by_name(location_array[1])[0].alpha2)
  end

  def get_access_token
    @token = @access_token.token
    @auth = @user.authentications.find_by(provider: params[:provider])
    @auth.update(token: @token)
  end

  def auth_params
    params.permit(:code, :provider)
  end
end
