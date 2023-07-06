class RenameRoleInActors < ActiveRecord::Migration[5.2]
  def change
    rename_column :actors, :role, :responsibility
  end
end
