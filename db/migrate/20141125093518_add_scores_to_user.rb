class AddScoresToUser < ActiveRecord::Migration
  def up
    add_column :users, :scores, :hstore
  end

  def down
    remove_column :users, :scores
  end
end
