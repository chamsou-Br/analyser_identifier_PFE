class ChangeRiskImpactDescriptionForeignKeys < ActiveRecord::Migration[5.1]
  def change
    rename_column :risk_impact_descriptions, :risk_scale_rating_id, :rating_id
    rename_column :risk_impact_descriptions, :risk_impact_id, :impact_id
  end
end
