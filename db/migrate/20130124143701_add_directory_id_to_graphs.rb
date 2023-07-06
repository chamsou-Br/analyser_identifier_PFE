class AddDirectoryIdToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :directory_id, :integer
  end
end
