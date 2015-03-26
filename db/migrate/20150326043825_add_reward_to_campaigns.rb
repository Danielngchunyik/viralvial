class AddRewardToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :reward, :integer, default: 0
  end
end
