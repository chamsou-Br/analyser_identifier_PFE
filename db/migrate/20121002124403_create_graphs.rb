class CreateGraphs < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs do |t|
      t.string :title
      t.string :type
      t.integer :level
      t.string :state
      t.string :reference
      t.string :description, :limit => 765

      t.timestamps
    end
  end
end
