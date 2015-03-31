class CreateRewardTransactions < ActiveRecord::Migration
  def change
    create_table :reward_transactions do |t|
      t.integer :user_id
      t.integer :campaign_id
      t.float :amount, default: 0
      t.boolean :paid, default: false

      t.timestamps null: false
    end
  end
end
