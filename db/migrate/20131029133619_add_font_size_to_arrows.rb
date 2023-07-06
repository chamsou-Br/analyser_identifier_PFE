class AddFontSizeToArrows < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :font_size, :integer
  end
end
