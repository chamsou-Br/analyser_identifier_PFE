class ChangeDescriptionInRiskScaleRatingToText < ActiveRecord::Migration[5.2]
  def change
    change_column :risk_scale_ratings, :description, :text 
  end
end
