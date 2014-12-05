class PostService
  attr_accessor :fb_token, :post_params, :fb_post, :campaign_id, :current_user, :post

  def initialize(fb_token, post_params, campaign_id, current_user)
    @fb_token = fb_token
    @post_params = post_params
    @campaign_id = campaign_id
    @current_user = current_user
  end

  def save
    create_fb_post!
    @post = @current_user.posts.build(post_params)
    @post.facebook_post_id = @fb_post.raw_attributes['id']
    @post.campaign_id = @campaign_id
    @post.save
  end

  private

  def create_fb_post!
    @fb_post = FbGraph::User.me(@fb_token).feed!(message: @post_params[:message])
  end
end
