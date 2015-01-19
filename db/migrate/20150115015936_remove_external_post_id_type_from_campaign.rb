class RemoveExternalPostIdTypeFromCampaign < ActiveRecord::Migration
  def change
    remove_column :posts, :external_post_id_type
  end
end
