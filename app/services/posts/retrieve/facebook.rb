class Posts::Retrieve::Facebook < Posts::FacebookBase

  def display
    @fb_post = FbGraph::Post.fetch(@post.external_post_id, access_token: @token)

    [@fb_post.likes.count, @fb_post.comments.count]
  end
end
