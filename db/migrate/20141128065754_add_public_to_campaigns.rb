class AddPublicToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :private, :boolean, default: false
  end
end
