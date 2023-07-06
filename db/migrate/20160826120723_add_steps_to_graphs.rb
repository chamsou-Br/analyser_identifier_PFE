class AddStepsToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :steps, :text, :limit => 1000000
  end
end
