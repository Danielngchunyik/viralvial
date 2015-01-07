class Posts::Facebook::Create
  attr_accessor :fb_token, :post_params, :fb_post, :campaign_id, :current_user, :post

  def initialize(fb_token, post_params, campaign_id, current_user)
    @fb_token = fb_token
    @post_params = post_params
    @campaign_id = campaign_id
    @current_user = current_user
  end

  def save
    create_fb_post!
    @post = @current_user.posts.build(@post_params, 
                                      external_post_id: @fb_post.raw_attributes['id'],
                                      external_post_id_type: "facebook",
                                      campaign_id: @campaign_id
                                     )
    @post.save
  end

  private

  def create_fb_post!
    
    if @post_params[:image] == nil
      @fb_post = FbGraph::User.me(@fb_token).feed!(message: @post_params[:message])
    else
      @fb_post = FbGraph::User.me(@fb_token).photo!(
        url: @post_params[:image],
        message: @post_params[:message]
      )
    end
  end
end