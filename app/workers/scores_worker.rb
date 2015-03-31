class ScoresWorker
  include Sidekiq::Worker

  def perform
  follower_list = SocialScore.pluck(:total_followers)
  average_score_list = SocialScore.pluck(:average_post_scores)

    SocialScore.find_each do |social_score|
      follower_percentile_score = calculate_percentile_score(follower_list, social_score.total_followers)
      post_performance_score = calculate_percentile_score(average_score_list, social_score.average_post_scores)

      social_score.viral_score = follower_percentile_score + post_performance_score)
    end
  end

  private

  # Formula for percentile score

  def calculate_percentile_score(list_of_values , compared_value)
    less, same = split_values(list_of_values, compared_value)

    ((less.length + (0.5 * same.length))/list_of_values.length * 45).round(2)
  end

  def split_values(list_of_values, compared_value)

    less = []
    same = []

    list_of_values.each do |value|
      if value < compared_value
        less << value
      elsif value == compared_value
        same << value
      end
    end

    [less, same]
  end
end
