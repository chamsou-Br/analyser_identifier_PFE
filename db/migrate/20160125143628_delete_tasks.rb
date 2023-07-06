class DeleteTasks < ActiveRecord::Migration[4.2]
  def change
    drop_table :tasks
  end
end
