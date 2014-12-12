class AddCriteriaToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :criteria, :text
  end
end
