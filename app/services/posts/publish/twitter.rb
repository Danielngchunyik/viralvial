class Posts::Publish::Twitter < Posts::Base

  def save
    tweet!

    save_post!(@tweet.id, "twitter", @topic_id)
  end

  private

  def tweet!
    @twitter = Posts::InitializeTwitterClient.new(@tw_token, @tw_secret)

    if @post_params[:image] == "nothing"
      tweet_without_img
    else
      tweet_with_img
    end
  end

  def tweet_without_img
    @tweet = @twitter.client.update(@post_params[:message])
  end

  def tweet_with_img
    @tweet = @twitter.client.update_with_media(
             @post_params[:message], open(@post_params[:image]), {}
             )
  end
end