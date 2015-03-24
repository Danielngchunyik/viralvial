class Oauth::RetrieveTwitterUserInfo
  attr_accessor :token, :secret, :user, :screen_name, :country

  def initialize(access_token, country)
    @token = access_token.token
    @secret = access_token.secret
    @screen_name = access_token.params[:screen_name]
    @country = country
  end

  def save
    @twitter = Initializer::TwitterClient.new(token, secret)
    @twitter_user = @twitter.client.user(screen_name)

    get_user_location_and_image

    @user = User.create(location: @user_location[0], name: @twitter_user.name, 
                        country: IsoCountryCodes.search_by_name(country)[0].alpha2, remote_image_url: @user_image)

    create_new_authentication

    return @user
  end

  private

  def get_user_location_and_image
    @user_location = @twitter_user.location.present? ? @twitter_user.location.split(', ') : ["None"]
    @user_image = @twitter_user.profile_image_url_https.to_str.gsub!("normal", "400x400")
  end

  def create_new_authentication
    @user.authentications.build(provider: 'twitter', uid: @twitter_user.id, token: token, secret: secret).save
  end
end
