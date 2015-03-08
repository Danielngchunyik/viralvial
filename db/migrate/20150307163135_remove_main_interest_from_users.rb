class RemoveMainInterestFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :main_interest, :string
  end
end
