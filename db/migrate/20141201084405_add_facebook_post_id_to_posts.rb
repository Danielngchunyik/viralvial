class AddFacebookPostIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :external_post_id, :string
    add_column :posts, :external_post_id_type, :string
  end
end
