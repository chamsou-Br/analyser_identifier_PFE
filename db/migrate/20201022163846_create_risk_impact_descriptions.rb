class CreateRiskImpactDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :risk_impact_descriptions do |t|
      t.string :description
      t.references :risk_impact, foreign_key: true
      t.references :risk_scale_rating, foreign_key: true

      t.timestamps
    end
  end
end
