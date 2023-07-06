class AddColumnFavoriteToGraphsUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs_users, :favorite, :boolean, :default => false
  end
end
