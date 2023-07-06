class CreateGraphSteps < ActiveRecord::Migration[4.2]
  def change
    create_table :graph_steps do |t|
      t.integer :graph_id
      t.text :set, :limit => 1000000

      t.timestamps
    end
  end
end
