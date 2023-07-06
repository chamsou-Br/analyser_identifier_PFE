class FixElementsParentColumn < ActiveRecord::Migration[4.2]
  def change
    rename_column :elements, :parent, :parent_lane
  end
end
