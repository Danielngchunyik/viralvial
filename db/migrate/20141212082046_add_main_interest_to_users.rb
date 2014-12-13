class AddMainInterestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :main_interest, :string
  end
end
