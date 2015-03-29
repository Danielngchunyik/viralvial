class Posts::Facebook::Retrieve < Posts::FacebookBase
  include ActionView::Helpers::TextHelper

  def display
    begin
      @fb_post = FbGraph::Post.fetch(post.external_post_id, access_token: @token)

      { one: pluralize(@fb_post.likes.count, 'like'), two: pluralize(@fb_post.comments.count, 'comment') }
    rescue 
      post.update(status: "deleted")
      
      { one: "0 likes", two: "0 comments", warning: "Warning: Post was deleted" }
    end
  end
end
