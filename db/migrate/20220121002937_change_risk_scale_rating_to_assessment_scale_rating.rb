class ChangeRiskScaleRatingToAssessmentScaleRating < ActiveRecord::Migration[5.2]
  def change
    rename_table :risk_scale_ratings, :assessment_scale_ratings
  end
end
