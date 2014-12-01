class Post < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :user
  has_many :tasks

  def retrieve_facebook_stats(fb_token, current_user)
    fb_post = FbGraph::Post.fetch(self.facebook_post_id, access_token: fb_token)

    fb_likes = 0
    fb_comments = 0
    fb_privacy = fb_post.raw_attributes["privacy"]["value"]

    fb_post.raw_attributes["likes"]["data"].each do |like|
      if like["name"] != current_user.name
        fb_likes += 1
      end
    end

    fb_post.raw_attributes["comments"]["data"].each do |comment|
      if comment["from"]["name"] != current_user.name
        fb_comments += 1
      end
    end

    return fb_likes, fb_comments, fb_privacy
  end
end
