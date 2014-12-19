class Posts::Facebook::CreateWithPhoto
  attr_accessor :fb_token, :post_params, :fb_post, :campaign_id, :current_user, :post

  def initialize(fb_token, post_params, campaign_id, current_user)
    @fb_token = fb_token
    @post_params = post_params
    @campaign_id = campaign_id
    @current_user = current_user
  end

  def save
    @post = @current_user.posts.build(@post_params)
    @post.save
    create_fb_post!
    @post.update_attributes(external_post_id: @fb_post.raw_attributes['id'], external_post_id_type: "facebook", campaign_id: @campaign_id)
  end

  private

  def create_fb_post!
    @fb_post = FbGraph::User.me(@fb_token).photo!(
      url: @post.image.url,
      message: @post.message
    )
  end
end
