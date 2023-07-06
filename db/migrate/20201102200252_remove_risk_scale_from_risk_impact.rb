class RemoveRiskScaleFromRiskImpact < ActiveRecord::Migration[5.1]
  def change
    remove_reference :risk_impacts, :risk_scale, foreign_key: true
  end
end
