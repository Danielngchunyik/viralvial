class AddPublicToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :privacy, :boolean, default: false
  end
end
