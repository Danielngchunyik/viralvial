class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :fb_likes
      t.integer :fb_comments
      t.integer :campaign_id

      t.timestamps
    end
  end
end
