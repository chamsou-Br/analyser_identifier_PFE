class RenameGraphsContributorsToContributablesContributors < ActiveRecord::Migration[4.2]
  def change
    rename_table :graphs_contributors, :contributables_contributors
    rename_column :contributables_contributors, :graph_id, :contributable_id
    add_column :contributables_contributors, :contributable_type, :string

    execute <<-SQL
      UPDATE contributables_contributors SET contributable_type = 'Graph'
    SQL
  end
end
