class AddEvaluationSystemToRiskScales < ActiveRecord::Migration[5.2]
  def change
    add_reference :risk_scales, :evaluation_system, type: :integer, foreign_key: true
  end
end
