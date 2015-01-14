class Posts::Retrieve::Facebook < Posts::FacebookBase

  def display
    @fb_post = FbGraph::Post.fetch(@post.external_post_id, access_token: @token)

    [@fb_post.raw_attributes['likes'], @fb_post.raw_attributes['comments']]
  end
end
