class AddFavoriteToDocument < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :favorite, :boolean, :default => false
  end
end
