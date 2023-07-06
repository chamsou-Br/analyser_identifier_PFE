class CreateRiskStateChanges < ActiveRecord::Migration[4.2]
  def change
    create_table :risk_state_changes do |t|
      t.references :risk, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
