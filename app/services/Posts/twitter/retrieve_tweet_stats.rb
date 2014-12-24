class Posts::Twitter::RetrieveTweetStats
  include Twitter::Initializer

  attr_accessor :tw_token, :tw_secret, :current_user, :post

  def initialize(tw_token, tw_secret, current_user, post)
    @token = tw_token
    @secret = tw_secret
    @current_user = current_user
    @post = post
  end

  def display
    retrieve_twitter_stats!

    favourites = @tweet.favorite_count
    retweets = @tweet.retweet_count

    [favourites, retweets]
  end

  private

  def retrieve_twitter_stats!
    initialize_client(@token, @secret)
    @tweet = @client.status(@post.external_post_id)
  end
end