class RenameIndexInStateMachinesStateChange < ActiveRecord::Migration[5.1]
  def change
    rename_index :state_machines_state_changes,
      "index_state_machines_state_changes_on_entity_type_and_entity_id",
      "index_state_machines_state_changes_on_entity"
  end
end
