class Posts::Facebook::Retrieve < Posts::FacebookBase

  def display
    begin
      @fb_post = FbGraph::Post.fetch(post.external_post_id, access_token: @token)

      [@fb_post.likes.count, @fb_post.comments.count]
    rescue 
      [0,0, "Warning: Post was deleted"]
    end
  end
end
