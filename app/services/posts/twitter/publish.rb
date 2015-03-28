class Posts::Twitter::Publish < Posts::TwitterBase

  def save
    tweet!

    @tweet.id
  end

  private

  def tweet!
    if post.image == "nothing"
      tweet_without_img
    else
      tweet_with_img
    end
  end

  def tweet_without_img
    @tweet = @twitter.client.update(post.message)
  end

  def tweet_with_img
    @tweet = @twitter.client.update_with_media(
             post.message, open(post.image), {}
             )
  end
end