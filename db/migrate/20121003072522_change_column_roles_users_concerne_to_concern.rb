class ChangeColumnRolesUsersConcerneToConcern < ActiveRecord::Migration[4.2]
  def change
    rename_column :roles_users, :concerne, :concern
  end
end
