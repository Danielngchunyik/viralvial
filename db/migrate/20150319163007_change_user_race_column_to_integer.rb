class ChangeUserRaceColumnToInteger < ActiveRecord::Migration
  def change
    change_column :users, :race, 'integer USING CAST(column_name AS integer)'
  end
end
