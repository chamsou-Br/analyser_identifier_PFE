class AddAuthorIdToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :author_id, :integer
  end
end
