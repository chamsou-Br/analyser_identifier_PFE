class AddDeactivatedColumnToResources < ActiveRecord::Migration[4.2]
  def change
    add_column :resources, :deactivated, :boolean, :default => false
  end
end
