class CreateLanes < ActiveRecord::Migration[4.2]
  def change
    create_table :lanes do |t|
      t.integer :graph_id
      t.decimal :x, :precision => 9, :scale => 4
      t.decimal :width, :precision => 9, :scale => 4

      t.timestamps
    end
  end
end
