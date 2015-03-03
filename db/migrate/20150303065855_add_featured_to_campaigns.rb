class AddFeaturedToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :featured, :boolean
  end
end
