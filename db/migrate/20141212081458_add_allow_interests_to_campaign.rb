class AddAllowInterestsToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :allow_interest, :boolean, default: false
  end
end
