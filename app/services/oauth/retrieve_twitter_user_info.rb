class Oauth::RetrieveTwitterUserInfo
  attr_accessor :token, :secret, :user, :screen_name, :country, :new_user

  def initialize(access_token, country=nil, user = nil)
    @token = access_token.token
    @secret = access_token.secret
    @screen_name = access_token.params[:screen_name]
    @country = country
    @user = user
  end

  def save

    # Create new user
    set_user_params
    get_user_location_and_image

    @new_user = User.create(location: @user_location[0], name: @twitter_user.name, twitter_followers: @twitter_user.followers_count, 
                            country: IsoCountryCodes.search_by_name(country)[0].alpha2, remote_image_url: @user_image)

    create_new_authentication(@new_user)

    return @new_user
  end

  def update_followers
    set_user_params

    user.update(twitter_followers: @twitter_user.followers_count)
  end

  private

  def set_user_params
    @twitter = Initializer::TwitterClient.new(token, secret)
    @twitter_user = @twitter.client.user(screen_name)
  end

  def get_user_location_and_image
    @user_location = @twitter_user.location.present? ? @twitter_user.location.split(', ') : ["None"]
    @user_image = @twitter_user.profile_image_url_https.to_str.gsub!("normal", "400x400")
  end

  def create_new_authentication(user)
    user.authentications.build(provider: 'twitter', uid: @twitter_user.id, token: token, secret: secret).save
  end
end
