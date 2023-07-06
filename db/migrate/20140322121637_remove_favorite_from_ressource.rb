class RemoveFavoriteFromRessource < ActiveRecord::Migration[4.2]
  def change
    remove_column :resources, :favorite
  end
end
