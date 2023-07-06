class AddDeactivatedColumnToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :roles, :deactivated, :boolean, :default => false
  end
end
