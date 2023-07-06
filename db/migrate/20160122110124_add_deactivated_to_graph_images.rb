class AddDeactivatedToGraphImages < ActiveRecord::Migration[4.2]
  def change
    add_column :graph_images, :deactivated, :boolean, :default => false
  end
end
