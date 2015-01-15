class Posts::Retrieve::Twitter < Posts::TwitterBase

  def display
    @tweet = @twitter.status(@post.external_post_id)

    [@tweet.favorite_count, @tweet.retweet_count]
  end
end
