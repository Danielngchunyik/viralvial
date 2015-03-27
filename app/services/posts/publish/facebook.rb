class Posts::Publish::Facebook < Posts::FacebookBase

  def save
    create_fb_post!

    @fb_post.raw_attributes['id']
  end
 
  private

  def create_fb_post!
    if post.image == "nothing"
      post_without_img
    else
      post_with_img
    end
  end

  def post_without_img
    @fb_post = FbGraph::User.me(@token).feed!(message: post.message)
  end

  def post_with_img
    @fb_post = FbGraph::User.me(@token).photo!(
      url: post.image,
      message: post.message
    )
  end
end
