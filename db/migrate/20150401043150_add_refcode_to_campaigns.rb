class AddRefcodeToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :refcode, :string
  end
end
