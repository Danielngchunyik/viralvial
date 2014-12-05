class AddFacebookPostIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :facebook_post_id, :string
  end
end
