class AddFontSizeToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :font_size, :integer
  end
end
