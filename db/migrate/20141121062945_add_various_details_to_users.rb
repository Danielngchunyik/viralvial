class AddVariousDetailsToUsers < ActiveRecord::Migration
  def change
    # add_column :users, :name, :string, default: ""
    # add_column :users, :birthdate, :datetime
    # add_column :users, :gender, :string
    # add_column :users, :race, :string, default: ""
    # add_column :users, :religion, :string, default: ""
    # add_column :users, :contact_number, :string
    # add_column :users, :income_range, :string
    # add_column :users, :nationality, :string
    # add_column :users, :state, :string
    # add_column :users, :country, :string
    # add_column :users, :marital_status, :string

    add_column :users do |t|
      t.string :name
      t.datetime :birthdate
      t.integer :gender
      t.string :race
      t.string :religion
      t.string :contact_number
      t.string :income_range
      t.string :nationality
      t.string :state
      t.string :country
      t.string :marital_status
    end
end
