class Provider::Twitter < Provider::Base
  attr_accessor :tw_token, :tw_secret

  def initialize; end

  def name
    'twitter'
  end

  def post_type
    'Tweet'
  end

  def retrieve_post
    @twitter_service = Posts::Twitter::RetrieveTweetStats.new(@tw_token, @tw_secret, @user, @post)
    @favourites, @retweets = @twitter_service.display
  rescue => e
    logger.info ''
    logger.info "[ERROR]: #{e.inspect}"
    logger.info ''
  end

  def remove_post!(tweet = @post)
    @post_service = Posts::Twitter::Destroy.new(@tw_token, @tw_secret, tweet)
  end

  def publish!
    @post_service = Posts::Twitter::Create.new(@tw_token, @tw_secret, @post_params, @topic_id, @user)
  end

  private

  def set_token
    auth = @user.authentications.find_by(provider: 'twitter')
    @tw_token = auth.token
    @tw_secret = auth.secret
  end
end
