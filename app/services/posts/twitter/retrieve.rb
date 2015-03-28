class Posts::Twitter::Retrieve < Posts::TwitterBase

  def display
    begin
      @tweet = @twitter.client.status(post.external_post_id)

      [@tweet.favorite_count, @tweet.retweet_count]
    rescue
      [0,0, "Warning: Tweet was deleted"]
    end
  end
end
