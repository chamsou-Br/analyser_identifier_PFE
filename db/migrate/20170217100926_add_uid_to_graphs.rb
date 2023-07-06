class AddUidToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :uid, :string, after: :id
  end
end
