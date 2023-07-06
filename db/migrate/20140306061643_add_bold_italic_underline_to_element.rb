class AddBoldItalicUnderlineToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :bold, :boolean, :default => false
    add_column :elements, :italic, :boolean, :default => false
    add_column :elements, :underline, :boolean, :default => false
  end
end
