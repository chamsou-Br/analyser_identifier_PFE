class CreateGraphsLogs < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_logs do |t|
      t.integer :graph_id
      t.string :action
      t.string :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
