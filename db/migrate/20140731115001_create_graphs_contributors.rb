class CreateGraphsContributors < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_contributors do |t|
      t.integer :contributor_id
      t.integer :graph_id

      t.timestamps
    end
  end
end
