class CreateFeatured < ActiveRecord::Migration
  def change
    create_table :featureds do |t|
      t.references :featurable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
