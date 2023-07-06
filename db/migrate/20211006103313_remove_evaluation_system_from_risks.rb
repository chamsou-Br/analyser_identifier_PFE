class RemoveEvaluationSystemFromRisks < ActiveRecord::Migration[5.2]
  def change
    remove_reference :risks, :evaluation_system, foreign_key: true
  end
end
