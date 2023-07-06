class ChangeRiskImpactDescriptionDescriptionToText < ActiveRecord::Migration[5.1]
  def change
    # Renames `description` column to `text` to avoid redundancy.
    rename_column :risk_impact_descriptions, :description, :text
  end
end
