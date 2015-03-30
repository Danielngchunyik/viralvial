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
    # Perform viral scores updates
    ScoresWorker.perform_async
  end

  def tally_total_followers
    update(total_followers: facebook_followers + twitter_followers)
  end

  def fetch_and_save_new_follower_count(provider)
    auth = user.authentications.find_by(provider: provider)
    
    if auth
      access_token = AccessToken.new(auth.try(:token), auth.try(:secret))

      klass = "Oauth::Retrieve#{provider.capitalize}UserInfo".constantize
      klass.new(access_token, nil, user).update_followers
    else

      # if authentications is not there, reset to 0
      attr = "#{provider}_followers".to_sym
      update(attr => 0)
    end
  end

  def followers_changed?
    new_total_count = facebook_followers + twitter_followers

    new_total_count != total_followers
  end
end
