class UpdateIndexInFieldItems < ActiveRecord::Migration[5.2]
  def change
    remove_index :field_items, [:sequence, :form_field_id]
    add_index :field_items, [:sequence, :form_field_id, :parent_id], unique: true
  end
end
