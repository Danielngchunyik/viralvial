class ChangeUserReligionColumnToInteger < ActiveRecord::Migration
  def change
    change_column :users, :religion, 'integer USING CAST(religion AS integer)'
  end
end
