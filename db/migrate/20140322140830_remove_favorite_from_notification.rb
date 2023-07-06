class RemoveFavoriteFromNotification < ActiveRecord::Migration[4.2]
  def change
    remove_column :notifications, :favorite
  end
end
