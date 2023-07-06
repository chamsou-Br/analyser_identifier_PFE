class AddIndexesForLists < ActiveRecord::Migration[4.2]
  def change
    add_index :field_items, [:sequence, :form_field_id], unique: true
    add_index :form_fields, [:customer_id, :module, :form_type, :sequence], name: 'unique_composite_index_on_form_fields', unique: true
  end
end
