class Posts::Facebook::Delete < Posts::FacebookBase

  def destroy
    FbGraph::Post.new(post.external_post_id, access_token: @token).destroy
  rescue
  end
  
end
