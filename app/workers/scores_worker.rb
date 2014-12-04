class ScoresWorker
  include Sidekiq::Worker

  def perform
    total_followers = User.pluck("(scores -> 'followers')::integer").compact

    User.find_each do |user|
      if user.followers.present?
        less_followers, same_followers = split_followers(total_followers, user)

        user.reach_score = ((less_followers.length + (0.5 * same_followers.length))/total_followers.length * 100).round(2)
        user.sx_index = ((user.localization.to_f + user.reach_score.to_f)/200*100).round(2)
        user.influence_score = ((user.klout.to_f + user.sx_index.to_f)/200*100).round(2)
        user.socialite_score = (user.influence_score.to_f + user.karma.to_f).round(2)
        # TODO: https://github.com/rails/rails/pull/15674
        user.scores_will_change!
        user.save
      end
    end
  end

  private

  def split_followers(followers, user)
    less, same = []
    followers.each do |tf|
      if tf < user.followers.to_i
        less << tf
      elsif tf == user.followers.to_i
        same << tf
      end
    end
    [less, same]
  end
end
