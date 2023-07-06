class AddFavoriteToResource < ActiveRecord::Migration[4.2]
  def change
    add_column :resources, :favorite, :boolean, :default => false
  end
end
