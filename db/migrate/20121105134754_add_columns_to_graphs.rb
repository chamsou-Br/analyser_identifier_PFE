class AddColumnsToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :version, :string
    add_column :graphs, :model_id, :integer
    add_column :graphs, :purpose, :string, :limit => 765
  end
end
