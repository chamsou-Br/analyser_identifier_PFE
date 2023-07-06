class RemoveActiveFromEvaluationSystems < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluation_systems, :active, :boolean
  end
end
