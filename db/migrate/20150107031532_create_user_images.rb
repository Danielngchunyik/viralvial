class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :storage

      t.timestamps null: false
    end
  end
end
