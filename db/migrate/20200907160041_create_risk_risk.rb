class CreateRiskRisk < ActiveRecord::Migration[5.1]
  def change
    create_table :risk_risks do |t|
      t.references :risk, type: :integer, index: true, foreign_key: true
      t.references :linked_risk, type: :integer, index: true

      t.timestamps null: false
    end

    add_foreign_key :risk_risks, :risks, column: :linked_risk_id
    add_index :risk_risks, [:risk_id, :linked_risk_id], unique: true
  end
end
