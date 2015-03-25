class SocialScore < ActiveRecord::Base
  belongs_to :user
  after_save :tally_total_followers, if: :followers_changed?
  after_save :update_social_scores, if: :followers_changed?
  
  def update_followers
    ["facebook", "twitter"].each do |provider|  
      fetch_and_save_new_follower_count(provider)
    end
  end

  private

  def update_social_scores
    ScoresWorker.perform_async
  end

  def tally_total_followers
    self.update(total_followers: self.facebook_followers + self.twitter_followers)
  end

  def fetch_and_save_new_follower_count(provider)
    return unless auth = self.user.authentications.find_by(provider: provider)
    access_token = AccessToken.new(auth.try(:token), auth.try(:secret))

    klass = "Oauth::Retrieve#{provider.capitalize}UserInfo".constantize
    klass.new(access_token, nil, self.user).update_followers
  end

  def followers_changed?
    new_total_count = self.facebook_followers + self.twitter_followers

    new_total_count != self.total_followers
  end
end
