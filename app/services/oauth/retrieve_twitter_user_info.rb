class Oauth::RetrieveTwitterUserInfo
  attr_accessor :token, :secret, :user, :screen_name

  def initialize(token, secret, user, screen_name)
    @token = token
    @secret = secret
    @user = user
    @screen_name = screen_name
  end

  def save
    @twitter = Initializer::TwitterClient.new(@token, @secret)

    twitter_user = @twitter.client.user(@screen_name)
    upload_profile_image(twitter_user)

    @user.update(location: twitter_user.location, name: twitter_user.name)
  end

  private

  def upload_profile_image(user)
    image_extract = user.profile_image_url_https.to_str.gsub!("normal", "400x400")
    @user.remote_image_url = image_extract
  end
end
