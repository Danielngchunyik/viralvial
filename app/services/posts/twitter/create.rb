class Posts::Twitter::Create
  include Twitter::Initializer
  include Posts::Shared::SavePost

  attr_accessor :tw_token, :tw_secret, :post_params, :topic_id, :current_user, :post

  def initialize(tw_token, tw_secret, post_params, topic_id, current_user)
    @token = tw_token
    @secret = tw_secret
    @post_params = post_params
    @topic_id = topic_id
    @current_user = current_user
  end

  def save
    tweet!

    save_post!(@tweet.id, "twitter")
  end

  private

  def tweet! 
    initialize_client(@token, @secret)

    if @post_params[:image] == "nothing"
      @tweet = @client.update(@post_params[:message])
    else
      @tweet = @client.update_with_media(@post_params[:message], open(@post_params[:image]), options = {})
    end
  end
end
