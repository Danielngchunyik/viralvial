class Posts::Twitter::Create
  include Twitter::Initializer

  attr_accessor :tw_token, :tw_secret, :post_params, :campaign_id, :current_user, :post

  def initialize(tw_token, tw_secret, post_params, campaign_id, current_user)
    @token = tw_token
    @secret = tw_secret
    @post_params = post_params
    @campaign_id = campaign_id
    @current_user = current_user
  end

  def save
    tweet!

    @post = @current_user.posts.build(@post_params)
    @post.external_post_id = @tweet.id
    @post.external_post_id_type = "twitter"
    @post.campaign_id = @campaign_id
    @post.save
  end

  private

  def tweet! 
    initialize_client(@token, @secret)
    @tweet = @client.update(@post_params[:message])
  end
end