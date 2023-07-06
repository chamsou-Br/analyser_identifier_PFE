class RemoveFavoriteFromGraph < ActiveRecord::Migration[4.2]
  def change
    remove_column :graphs, :favorite
  end
end
