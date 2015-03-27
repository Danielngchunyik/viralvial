class ChangePostTypeToProvider < ActiveRecord::Migration
  def change
    rename_column :posts, :type, :provider
  end
end
