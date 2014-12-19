class Posts::Twitter::CreateWithPhoto
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
    initialize_client(@token, @secret)
    @post = @current_user.posts.build(@post_params)
    @post.save
    tweet = @client.update_with_media(@post.message, open(@post.image.url), options = {})
    @post.update_attributes(external_post_id: tweet.id, external_post_id_type: "twitter", campaign_id: @campaign_id)
  end
end
