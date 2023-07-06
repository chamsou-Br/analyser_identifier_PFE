class RemoveParentIdFromFieldItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :field_items, :parent_id, :integer
  end
end
