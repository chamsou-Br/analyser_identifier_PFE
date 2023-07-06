class CreateArrows < ActiveRecord::Migration[4.2]
  def change
    create_table :arrows do |t|
      t.integer :graph_id
      t.integer :from_id
      t.integer :to_id
      t.decimal :x, :precision => 9, :scale => 4
      t.decimal :y, :precision => 9, :scale => 4
      t.decimal :width, :precision => 9, :scale => 4
      t.decimal :height, :precision => 9, :scale => 4
      t.string :text

      t.timestamps
    end
  end
end
