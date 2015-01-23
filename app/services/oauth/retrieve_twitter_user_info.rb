class Oauth::RetrieveTwitterUserInfo
  attr_accessor :token, :secret, :user, :screen_name

  def initialize(token, secret, user, screen_name)
    @token = token
    @secret = secret
    @user = user
    @screen_name = screen_name
  end

  def save
    @twitter = initialize_twitter_client(@token, @secret)

    twitter_user = @twitter.user(@screen_name)
    upload_profile_image(twitter_user)

    @user.update(location: twitter_user.location, name: twitter_user.name)
  end

  private

  def upload_profile_image(user)
    image_extract = user.profile_image_url_https.to_str.split("__")
    @user.remote_image_url = "#{image_extract[0]}__200x200.jpeg"
  end

  def initialize_twitter_client(token, secret)
    @consumer_key = ENV['TWITTER_KEY']
    @consumer_secret = ENV['TWITTER_SECRET']
    @access_token = token
    @access_token_secret = secret

    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = @consumer_key
      config.consumer_secret = @consumer_secret
      config.access_token = @access_token
      config.access_token_secret = @access_token_secret
    end
  end
end
