class RemoveDocWfFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :doc_wf
  end
end
