class AddTitleColorTitleFontfamilyToArrow < ActiveRecord::Migration[4.2]
  def change
    add_column :arrows, :title_color, :string
    add_column :arrows, :title_fontfamily, :string
  end
end
