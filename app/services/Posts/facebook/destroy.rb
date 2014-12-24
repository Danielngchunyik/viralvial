class Posts::Facebook::Destroy

  attr_accessor :fb_token, :post

  def initialize(fb_token, post)
    @fb_token = fb_token
    @post = post
  end

  def destroy
    delete_facebook_post!
    @post.destroy
  end

  private

  def delete_facebook_post!
    FbGraph::Post.new(@post.external_post_id, access_token: @fb_token).destroy
  end
end
