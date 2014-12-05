class AddVariousDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :integer
    add_column :users, :race, :string
    add_column :users, :religion, :string
    add_column :users, :contact_number, :string
    add_column :users, :nationality, :string
    add_column :users, :location, :string
    add_column :users, :country, :string
    add_column :users, :marital_status, :string
  end
end
