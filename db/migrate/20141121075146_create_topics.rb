class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
        t.integer :num_of_posts
        t.integer :num_of_likes
        t.integer :num_of_comments
        t.integer :campaign_id
        t.integer :social_media_platform

      t.timestamps
    end
  end
end
