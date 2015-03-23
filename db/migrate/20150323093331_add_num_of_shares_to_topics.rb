class AddNumOfSharesToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :num_of_shares, :integer
  end
end
