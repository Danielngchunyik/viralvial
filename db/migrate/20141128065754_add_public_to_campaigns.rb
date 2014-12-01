class AddPublicToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :public, :boolean, default: true
  end
end
