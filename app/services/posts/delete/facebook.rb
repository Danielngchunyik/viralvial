class Posts::Delete::Facebook < Posts::FacebookBase

  def destroy
    begin
      FbGraph::Post.new(@post.external_post_id, access_token: @token).destroy
    rescue
    end
  end
end
