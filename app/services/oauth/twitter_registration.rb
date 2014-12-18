class Oauth::TwitterRegistration
  include Twitter::Initializer

  attr_accessor :token, :secret, :user, :screen_name

  def initialize(token, secret, user, screen_name)
    @token = token
    @secret = secret
    @user = user
    @screen_name = screen_name
  end

  def save
    initialize_client(@token, @secret)

    twitter_user = @client.user(@screen_name)
    upload_profile_image(twitter_user)
    @user.update(location: twitter_user.location, name: twitter_user.name)
  end

  private

  def upload_profile_image(user)
    image_extract = user.profile_image_url_https.to_str.split("__")
    image = "#{image_extract[0]}__300x300.jpeg"

    @user.remote_image_url = image
  end

end
