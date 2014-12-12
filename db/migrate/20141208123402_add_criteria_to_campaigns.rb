class AddCriteriaToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :criteria, :hstore, default: {}
  end

  def down
    remove_column :users, :criteria
  end
end
