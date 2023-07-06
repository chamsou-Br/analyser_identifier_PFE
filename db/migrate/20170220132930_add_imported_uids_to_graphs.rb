class AddImportedUidsToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :imported_uid, :string
    add_column :graphs, :imported_groupgraph_uid, :string
  end
end
