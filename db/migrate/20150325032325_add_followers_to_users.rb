class AddFollowersToUsers < ActiveRecord::Migration
  def up
    add_column :users, :followers, :hstore, default: {}
  end
end
