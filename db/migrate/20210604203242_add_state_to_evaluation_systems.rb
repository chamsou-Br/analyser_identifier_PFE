class AddStateToEvaluationSystems < ActiveRecord::Migration[5.1]
  def change
    add_column :evaluation_systems, :state, :integer
  end
end
