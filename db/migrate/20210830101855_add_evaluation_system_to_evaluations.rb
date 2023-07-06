class AddEvaluationSystemToEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_reference :evaluations, :evaluation_system, type: :integer, foreign_key: true
  end
end
