class AddLanguageToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :language, :integer
  end
end
