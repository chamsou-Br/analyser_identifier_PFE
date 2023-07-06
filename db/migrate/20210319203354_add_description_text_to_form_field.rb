# frozen_string_literal: true

# This migration introduces the `description` column to the `form_fields` table.
# This field is intended to allow Pyx4 and customer administrators to describe
# dynamic form fields in greater details to help their end users better
# understand the meaning or function of a given field.
class AddDescriptionTextToFormField < ActiveRecord::Migration[5.1]
  def change
    add_column :form_fields, :description, :text, null: true
  end
end
