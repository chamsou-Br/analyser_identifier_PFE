class CreateGraphsRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_roles do |t|
      t.integer :role_id
      t.integer :graph_id

      t.timestamps
    end
  end
end
