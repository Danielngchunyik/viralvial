class Users::Authentication
  attr_accessor :provider, :access_token, :user, :country

  def initialize(provider, access_token, user = nil, country = nil)
    @provider = provider
    @access_token = access_token
    @user = user
    @country = country
  end

  def update_logged_in_user
    user.set_access_token(access_token, provider)
    user.social_score.update_followers
  end

  def register_new_user

    sanitize_klass(provider)

    new_user = @klass.new(access_token, country).save
  end

  def sanitize_klass(provider)
    allowed_klasses = [Oauth::RetrieveFacebookUserInfo, Oauth::RetrieveTwitterUserInfo]

    klass = "Oauth::Retrieve#{provider.capitalize}UserInfo"
    @klass = klass.sanitize_constant(allowed_klasses)
  end
end
