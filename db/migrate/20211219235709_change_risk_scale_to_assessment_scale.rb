class ChangeRiskScaleToAssessmentScale < ActiveRecord::Migration[5.2]
  def change
    rename_table :risk_scales, :assessment_scales
  end
end
