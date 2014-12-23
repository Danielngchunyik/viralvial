class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.boolean :status
      t.date :start_date
      t.date :end_date
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
