class AddNestedSetColumnsToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :parent_id, :integer
    add_column :elements, :lft, :integer
    add_column :elements, :rgt, :integer
  end
end
