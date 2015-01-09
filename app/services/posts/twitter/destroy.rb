class Posts::Twitter::Destroy

  attr_accessor :tw_token, :tw_secret, :post

  def initialize(tw_token, tw_secret, post)
    @token = tw_token
    @secret = tw_secret
    @post = post
  end

  def destroy
    delete_tweet!
    @post.destroy
  end

  private

  def delete_tweet!
    @twitter = TwitterService.new(@token, @secret)
    @twitter.client.destroy_status(@post.external_post_id)
  end
end
