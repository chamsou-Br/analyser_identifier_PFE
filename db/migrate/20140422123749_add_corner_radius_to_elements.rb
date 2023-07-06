class AddCornerRadiusToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :corner_radius, :integer
  end
end
