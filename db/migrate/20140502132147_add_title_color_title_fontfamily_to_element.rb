class AddTitleColorTitleFontfamilyToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :title_color, :string
    add_column :elements, :title_fontfamily, :string
  end
end
