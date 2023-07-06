class CreateGraphBackgrounds < ActiveRecord::Migration[4.2]
  def change
    create_table :graph_backgrounds do |t|
      t.string :file
      t.string :color

      t.timestamps
    end
  end
end
