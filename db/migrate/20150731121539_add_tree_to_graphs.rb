class AddTreeToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :tree, :boolean, :default => false
    add_column :groupgraphs, :tree, :boolean, :default => false
  end
end
