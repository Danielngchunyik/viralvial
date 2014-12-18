module Twitter::Initializer
  def initialize_client(token, secret)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = token
      config.access_token_secret = secret
    end
  end
end