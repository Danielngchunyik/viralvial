class Posts::Facebook::Create
  include Posts::Shared::SavePost

  attr_accessor :fb_token, :post_params, :fb_post, :topic_id, :current_user, :post

  def initialize(fb_token, post_params, topic_id, current_user)
    @fb_token = fb_token
    @post_params = post_params
    @topic_id = topic_id
    @current_user = current_user
  end

  def save
    create_fb_post!

    save_post!(@fb_post.raw_attributes['id'], "facebook", @topic_id)
  end

  private

  def create_fb_post!
    if @post_params[:image] == "nothing"
      @fb_post = FbGraph::User.me(@fb_token).feed!(message: @post_params[:message])
    else
      @fb_post = FbGraph::User.me(@fb_token).photo!(
        url: @post_params[:image],
        message: @post_params[:message]
      )
    end
  end
end
