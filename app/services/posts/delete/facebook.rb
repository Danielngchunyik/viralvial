class Posts::Delete::Facebook < Posts::Base

  def destroy
    delete_facebook_post!
    @post.destroy
  end

  private

  def delete_facebook_post!
    FbGraph::Post.new(@post.external_post_id, access_token: @fb_token).destroy
  end
end
