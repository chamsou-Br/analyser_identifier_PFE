class RenameLevelToRoleOnInvolvablesRole < ActiveRecord::Migration[4.2]
  def change
    rename_column :involvables_roles, :level, :role
  end
end
