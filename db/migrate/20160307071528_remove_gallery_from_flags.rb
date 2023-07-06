class RemoveGalleryFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :gallery
  end
end
