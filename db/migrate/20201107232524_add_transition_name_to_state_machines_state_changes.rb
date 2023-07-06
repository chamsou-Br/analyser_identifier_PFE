class AddTransitionNameToStateMachinesStateChanges < ActiveRecord::Migration[5.1]
  def change
    add_column :state_machines_state_changes, :transition_name, :string, null: false
  end
end
