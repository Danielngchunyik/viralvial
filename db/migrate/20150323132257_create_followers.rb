class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :social_platform
      t.integer :amount

      t.timestamps null: false
    end
  end
end
