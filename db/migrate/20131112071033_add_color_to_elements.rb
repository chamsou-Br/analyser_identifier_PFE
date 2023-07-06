class AddColorToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :color, :string
  end
end
