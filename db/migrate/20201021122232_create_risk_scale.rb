class CreateRiskScale < ActiveRecord::Migration[5.1]
  def change
    create_table :risk_scales do |t|
      t.references :impact_system, foreign_key: { to_table: :evaluation_systems }, type: :integer
      t.references :likelihood_system, foreign_key: { to_table: :evaluation_systems }, type: :integer
      t.references :threat_level_system, foreign_key: { to_table: :evaluation_systems }, type: :integer
    end
  end
end
