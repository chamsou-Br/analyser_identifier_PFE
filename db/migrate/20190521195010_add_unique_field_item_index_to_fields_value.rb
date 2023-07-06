# frozen_string_literal: true

class AddUniqueFieldItemIndexToFieldsValue < ActiveRecord::Migration[5.0]
  def change
    add_index :fields_values, %i[form_field_id field_item_id fieldable_id fieldable_type],
              unique: true,
              name: "form_field_items"
  end
end
