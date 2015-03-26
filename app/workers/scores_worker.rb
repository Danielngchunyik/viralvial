class ScoresWorker
  include Sidekiq::Worker

  def perform
    follower_list = SocialScore.pluck(:total_followers)

    SocialScore.find_each do |social_score|
      if social_score.total_followers.present?
        less_followers, same_followers = split_followers(follower_list, social_score)
        
        percentile_score = calculate_percentile_score(social_score, less_followers, same_followers, follower_list)
        
        performance_score = calculate_performance_score

        social_score.update(viral_score: percentile_score + performance_score)
      end
    end
  end

  private

  def calculate_performance_score
  end

  def calculate_percentile_score(social_score, less_followers, same_followers, total_followers)
    ((less_followers.length + (0.5 * same_followers.length))/total_followers.length * 50).round(2)
  end

  def split_followers(followers, social_score)
    less = []
    same = []
    followers.each do |follower|
      if follower < social_score.total_followers.to_i
        less << follower
      elsif follower == social_score.total_followers.to_i
        same << follower
      end
    end

    [less, same]
  end
end
