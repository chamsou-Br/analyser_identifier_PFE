class ChangeRiskScaleIdToAssessmentScaleId < ActiveRecord::Migration[5.2]
  def change
    rename_column :risk_scale_ratings, :risk_scale_id, :assessment_scale_id
  end
end
