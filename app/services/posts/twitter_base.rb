class Posts::TwitterBase < Posts::Base

  def post_type
    "Tweet"
  end

  def set_token
    auth = @user.authentications.find_by(provider: 'twitter')
    @token = auth.token
    @secret = auth.secret

    initialize_twitter_client(@token, @secret)
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
