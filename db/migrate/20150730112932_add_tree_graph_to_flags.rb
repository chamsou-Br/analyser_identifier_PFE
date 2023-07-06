class AddTreeGraphToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :tree_graph, :boolean, :default => false
  end
end
