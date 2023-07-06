class AddFavoriteToGraph < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :favorite, :boolean, :default => false
  end
end
