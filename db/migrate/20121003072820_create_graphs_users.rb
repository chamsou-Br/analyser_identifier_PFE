class CreateGraphsUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_users do |t|
      t.integer :graph_id
      t.integer :user_id

      t.timestamps
    end
  end
end
