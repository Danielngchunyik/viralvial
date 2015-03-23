class RemoveSocialMediaPlatformFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :social_media_platform
  end
end