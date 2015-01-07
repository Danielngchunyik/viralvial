class CreateDefaultImages < ActiveRecord::Migration
  def change
    create_table :default_images do |t|
      t.string :storage
      t.integer :campaign_id

      t.timestamps
    end
  end
end
