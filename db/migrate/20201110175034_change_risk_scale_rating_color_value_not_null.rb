class ChangeRiskScaleRatingColorValueNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :risk_scale_ratings, :color, false
    change_column_null :risk_scale_ratings, :value, false
  end
end
