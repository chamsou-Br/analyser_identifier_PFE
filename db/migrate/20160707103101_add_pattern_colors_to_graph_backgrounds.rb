class AddPatternColorsToGraphBackgrounds < ActiveRecord::Migration[4.2]
  def change
    add_column :graph_backgrounds, :pattern_fill_color, :string
    add_column :graph_backgrounds, :pattern_stroke_color, :string
  end
end
