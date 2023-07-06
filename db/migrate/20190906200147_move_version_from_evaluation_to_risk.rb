class MoveVersionFromEvaluationToRisk < ActiveRecord::Migration[5.0]
  def change
    remove_reference :evaluations, :version, index: true, foreign_key: true
    add_reference :risks, :version, index: true, foreign_key: true
  end
end
