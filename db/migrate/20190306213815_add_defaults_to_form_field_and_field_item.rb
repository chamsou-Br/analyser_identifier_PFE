# frozen_string_literal: true

class AddDefaultsToFormFieldAndFieldItem < ActiveRecord::Migration[5.0]
  def change
    change_column_default :form_fields, :required, from: nil, to: false
    change_column_default :form_fields, :visible, from: nil, to: true
    change_column_default :field_items, :activated, from: nil, to: true
  end
end
