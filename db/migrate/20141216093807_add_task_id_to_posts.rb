class AddTaskIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :task_id, :integer
  end
end
