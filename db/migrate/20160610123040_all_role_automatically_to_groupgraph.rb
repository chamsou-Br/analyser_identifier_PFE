class AllRoleAutomaticallyToGroupgraph < ActiveRecord::Migration[4.2]
  def up
    add_column :groupgraphs, :auto_role_viewer, :boolean, default: false
  end

  def down
    remove_column :groupgraphs, :auto_role_viewer
  end
end
