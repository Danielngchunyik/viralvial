class ScoresWorker
  include Sidekiq::Worker

  def perform
    #get user followers percentile
    total_followers = User.pluck("(scores -> 'followers')::integer")

    User.find_each do |user|
      less_followers = []
      same_followers = []
      total_followers.each do |tf|
        if tf < user.followers.to_i
          less_followers.push(tf)
        elsif tf == user.followers.to_i
          same_followers.push(tf)
        end
      end

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