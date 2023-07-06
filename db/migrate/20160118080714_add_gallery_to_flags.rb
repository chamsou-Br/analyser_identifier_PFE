class AddGalleryToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :gallery, :boolean, :default => false
  end
end
