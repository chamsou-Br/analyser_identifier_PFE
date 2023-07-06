class ChangeElementsParentLaneColumn < ActiveRecord::Migration[4.2]
  def change
    rename_column :elements, :parent_lane, :parent_role
  end
end
