class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
        t.integer :posts
        t.integer :likes
        t.integer :comments
        t.integer :campaign_id
        t.string :social_media_platform

      t.timestamps
    end
  end
end
