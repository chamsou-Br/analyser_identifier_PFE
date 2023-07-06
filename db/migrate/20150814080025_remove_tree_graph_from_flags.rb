class RemoveTreeGraphFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :tree_graph
  end
end
