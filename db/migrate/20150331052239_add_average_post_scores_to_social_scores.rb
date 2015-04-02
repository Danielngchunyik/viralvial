class AddAveragePostScoresToSocialScores < ActiveRecord::Migration
  def change
    add_column :social_scores, :average_post_score, :integer, default: 0
  end
end
