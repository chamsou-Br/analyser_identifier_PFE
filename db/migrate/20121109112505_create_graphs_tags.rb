class CreateGraphsTags < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs_tags, :id => false do |t|
      t.integer :graph_id
      t.integer :tag_id
    end
  end
end
