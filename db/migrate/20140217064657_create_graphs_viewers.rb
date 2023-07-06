class CreateGraphsViewers < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_viewers, :id => false do |t|
      t.integer :graph_id
      t.integer :viewer_id
    end
  end
end
