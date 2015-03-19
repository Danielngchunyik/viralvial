class ChangeRaceFormatForUsers < ActiveRecord::Migration
  def up
    change_column :users, :race, :integer
  end

  def down
    change_column :users, :race, :string
  end
end
