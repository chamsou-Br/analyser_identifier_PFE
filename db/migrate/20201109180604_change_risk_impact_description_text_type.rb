class ChangeRiskImpactDescriptionTextType < ActiveRecord::Migration[5.1]
  def change
    change_column :risk_impact_descriptions, :text, :text, limit: 65_535
  end
end
