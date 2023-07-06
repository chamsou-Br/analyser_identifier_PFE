class AddUidsToPackageGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :package_graphs, :graph_uid, :string, after: :graph_id
    add_column :package_graphs, :groupgraph_uid, :string, after: :groupgraph_id
  end
end
