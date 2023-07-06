class AddTasksManagerToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :tasks_manager, :boolean, :default => false
  end
end
