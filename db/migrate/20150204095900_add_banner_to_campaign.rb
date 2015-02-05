class AddBannerToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :banner, :string
  end
end
