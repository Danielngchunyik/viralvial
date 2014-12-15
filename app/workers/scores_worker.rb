class ScoresWorker
  include Sidekiq::Worker

  def perform
    total_followers = User.pluck("(scores -> 'followers')::integer").compact

    User.find_each do |user|
      if user.followers.present?
        less_followers, same_followers = split_followers(total_followers, user)

        update_scores(user, less_followers, same_followers, total_followers)
        user.save
      end
    end
  end

  private

  def update_scores(user, less_followers, same_followers, total_followers)
    user.reach_score = ((less_followers.length + (0.5 * same_followers.length))/total_followers.length * 100).round(2)
    user.sx_index = ((user.localization.to_f + user.reach_score.to_f)/200*100).round(2)
    user.influence_score = ((user.klout.to_f + user.sx_index.to_f)/200*100).round(2)
    user.socialite_score = (user.influence_score.to_f + user.karma.to_f).round(2)
  end

  def split_followers(followers, user)
    less = []
    same = []
    followers.each do |follower|
      if follower < user.followers.to_i
        less << follower
      elsif follower == user.followers.to_i
        same << follower
      end
    end
    [less, same]
  end
end
