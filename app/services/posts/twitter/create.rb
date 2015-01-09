class Posts::Twitter::Create
  include Posts::SavePost

  attr_accessor :token, :secret, :post_params, :topic_id, :current_user, :post

  def initialize(tw_token, tw_secret, post_params, topic_id, current_user)
    @token = tw_token
    @secret = tw_secret
    @post_params = post_params
    @topic_id = topic_id
    @current_user = current_user
  end

  def save
    tweet!

    @post = save_post!(@tweet.id, "twitter", @topic_id)
  end

  private

  def tweet!
    @twitter = TwitterService.new(@token, @secret)

    if @post_params[:image] == "nothing"
      @tweet = @twitter.client.update(@post_params[:message])
    else
      @tweet = @twitter.client.update_with_media(
                 @post_params[:message], open(@post_params[:image]), {}
               )
    end
  end
end
