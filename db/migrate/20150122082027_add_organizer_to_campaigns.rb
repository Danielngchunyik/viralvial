class AddOrganizerToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :organizer, :string
  end
end
