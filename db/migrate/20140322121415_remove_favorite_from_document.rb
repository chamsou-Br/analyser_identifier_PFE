class RemoveFavoriteFromDocument < ActiveRecord::Migration[4.2]
  def change
    remove_column :documents, :favorite
  end
end
