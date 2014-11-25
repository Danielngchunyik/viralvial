class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.boolean :status
      t.datetime :start_date
      t.datetime :end_date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
