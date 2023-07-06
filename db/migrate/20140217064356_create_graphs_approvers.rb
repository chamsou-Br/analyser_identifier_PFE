class CreateGraphsApprovers < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_approvers do |t|
      t.integer :graph_id
      t.integer :approver_id
      t.boolean :approved

      t.timestamps
    end
  end
end
