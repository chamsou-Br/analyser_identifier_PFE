# frozen_string_literal: true

class AddLinkableToFieldsValue < ActiveRecord::Migration[4.2]
  def change
    add_reference :fields_values, :linkable, polymorphic: true
    add_index :fields_values, %i[form_field_id linkable_id linkable_type],
              unique: true,
              name: "form_field_links"
  end
end
