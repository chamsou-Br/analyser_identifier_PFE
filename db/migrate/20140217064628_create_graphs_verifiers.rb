class CreateGraphsVerifiers < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_verifiers do |t|
      t.integer :graph_id
      t.integer :verifier_id
      t.boolean :verified

      t.timestamps
    end
  end
end
