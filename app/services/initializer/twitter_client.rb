class Initializer::TwitterClient
  attr_accessor :token, :secret, :client

  def initialize(token, secret)
    @token = token
    @secret = secret

    @consumer_key = ENV['TWITTER_KEY']
    @consumer_secret = ENV['TWITTER_SECRET']
    @access_token = token
    @access_token_secret = secret

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = @consumer_key
      config.consumer_secret = @consumer_secret
      config.access_token = @access_token
      config.access_token_secret = @access_token_secret
    end
  end
end