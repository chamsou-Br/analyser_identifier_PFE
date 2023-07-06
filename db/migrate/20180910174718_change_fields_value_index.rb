class ChangeFieldsValueIndex < ActiveRecord::Migration[4.2]
  def change
    remove_index :fields_values, name: 'form_field_links'
    add_index :fields_values, [:form_field_id, :linkable_id, :linkable_type, :fieldable_id, :fieldable_type],
      unique: true,
      name: 'form_field_links'
  end
end
