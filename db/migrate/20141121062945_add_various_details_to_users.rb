class AddVariousDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :birthdate, :datetime
    add_column :users, :gender, :integer
    add_column :users, :race, :string
    add_column :users, :religion, :string
    add_column :users, :contact_number, :string
    add_column :users, :income_range, :string
    add_column :users, :nationality, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :marital_status, :string
  end
end
