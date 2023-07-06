class AddParentIdToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :parent_id, :integer
  end
end
