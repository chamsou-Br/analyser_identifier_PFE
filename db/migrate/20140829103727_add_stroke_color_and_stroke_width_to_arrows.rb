class AddStrokeColorAndStrokeWidthToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :stroke_color, :string
    add_column :arrows, :stroke_width, :int
  end
end