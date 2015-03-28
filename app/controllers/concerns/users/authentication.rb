module Users::Authentication
  extend ActiveSupport::Concern

  def update_logged_in_user(provider)
    # Run updates on user's followers and access tokens
    @user.set_access_token(@access_token, provider)
    @user.social_score.update_followers

    flash[:success] = "You're logged in from #{provider.titleize}!"
    redirect_to user_path(current_user)
  end

  def register_new_user(provider)

    sanitize_klass(provider)

    @user = @klass.new(@access_token, @country).save

    reset_session

    auto_login(@user)
    
    flash[:notice] = "You've registered through #{provider.titleize}!"
    redirect_to user_path(current_user)
  end

  def link_account(provider)

    sanitize_klass(provider)
    add_provider_to_user(provider)

    current_user.set_access_token(@access_token, provider)
    @klass.new(@access_token, nil, current_user).update_followers
    
    flash[:notice] = "You have successfully linked your #{provider.titleize} account."
    redirect_to user_path(current_user)
  end

  def sanitize_klass(provider)
    allowed_klasses = [Oauth::RetrieveFacebookUserInfo, Oauth::RetrieveTwitterUserInfo]

    klass = "Oauth::Retrieve#{provider.capitalize}UserInfo"
    @klass = klass.sanitize_constant(allowed_klasses)
  end
end
