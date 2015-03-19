class ChangeUserRaceColumnToInteger < ActiveRecord::Migration
  def change
    change_column :users, :race, 'integer USING CAST(race AS integer)'
  end
end
