class AddColumnShapeToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :shape, :string
  end
end
