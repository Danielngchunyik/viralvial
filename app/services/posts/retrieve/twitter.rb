class Posts::Retrieve::Twitter < Posts::Base

  def display
    retrieve_twitter_stats!

    favourites = @tweet.favorite_count
    retweets = @tweet.retweet_count

    [favourites, retweets]
  end

  private

  def retrieve_twitter_stats!
    @twitter = Posts::InitializeTwitterClient.new(@tw_token, @tw_secret)
    @tweet = @twitter.client.status(@post.external_post_id)
  end
end
