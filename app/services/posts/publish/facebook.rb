class Posts::Publish::Facebook < Posts::Base

  def save
    create_fb_post!

    save_post!(@fb_post.raw_attributes['id'], "facebook", @topic_id)
  end
 
  private

  def create_fb_post!
    if @post_params[:image] == "nothing"
      post_without_img
    else
      post_with_img
    end
  end

  def post_without_img
    @fb_post = FbGraph::User.me(@fb_token).feed!(message: @post_params[:message])
  end

  def post_with_img
    @fb_post = FbGraph::User.me(@fb_token).photo!(
      url: @post_params[:image],
      message: @post_params[:message]
    )
  end
end
