class CreateSocialScores < ActiveRecord::Migration
  def change
    create_table :social_scores do |t|
      t.integer :facebook_followers, default: 0
      t.integer :twitter_followers, default: 0
      t.integer :total_followers, default: 0
      t.integer :user_id
      t.integer :viral_score, default: 0

      t.timestamps null: false
    end
  end
end
