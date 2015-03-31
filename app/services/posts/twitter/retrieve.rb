class Posts::Twitter::Retrieve < Posts::TwitterBase
  include ActionView::Helpers::TextHelper

  def display
    begin
      @tweet = @twitter.client.status(post.external_post_id)
      score = (@tweet.favorite_count * 2) + (@tweet.retweet_count * 10)

      post.update(score: score)

      { one: pluralize(@tweet.favorite_count, 'favourite'), two: pluralize(@tweet.retweet_count, 'retweet') }
    rescue
      post.update(status: "deleted")
      
      { one: "0 favourites", two: "0 retweets", warning: "Warning: Post was deleted" }
    end
  end
end
