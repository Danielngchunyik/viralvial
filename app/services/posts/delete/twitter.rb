class Posts::Delete::Twitter < Posts::Base

  def destroy
    delete_tweet!
    @post.destroy
  end

  private

  def delete_tweet!
    @twitter = Posts::InitializeTwitterClient.new(@tw_token, @tw_secret)
    @twitter.client.destroy_status(@post.external_post_id)
  end
end
