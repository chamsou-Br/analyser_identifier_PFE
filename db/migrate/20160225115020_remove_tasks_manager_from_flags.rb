class RemoveTasksManagerFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :tasks_manager
  end
end
