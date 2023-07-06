class RemoveStepsFromGraphs < ActiveRecord::Migration[4.2]
  def change
    remove_column :graphs, :steps
  end
end
