class AddGraphBackgroundToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :graph_background_id, :integer
  end
end
