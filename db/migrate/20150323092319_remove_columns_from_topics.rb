class RemoveColumnsFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :num_of_posts
    remove_column :topics, :num_of_likes
    remove_column :topics, :num_of_comments
  end
end
