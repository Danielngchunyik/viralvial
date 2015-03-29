class Posts::Twitter::Retrieve < Posts::TwitterBase
  include ActionView::Helpers::TextHelper

  def display
    begin
      @tweet = @twitter.client.status(post.external_post_id)

      { one: pluralize(@tweet.favorite_count, 'favourite'), two: pluralize(@tweet.retweet_count, 'retweet') }
    rescue
      post.update(status: "deleted")
      
      { one: "0 favourites", two: "0 retweets", warning: "Warning: Post was deleted" }
    end
  end
end
