class AddStateToRiskStateChanges < ActiveRecord::Migration[4.2]
  def change
    add_column :risk_state_changes, :state, :string, null: false
  end
end
