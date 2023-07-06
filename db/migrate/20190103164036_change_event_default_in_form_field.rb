# frozen_string_literal: true

class ChangeEventDefaultInFormField < ActiveRecord::Migration[4.2]
  def change
    rename_column :form_fields, :event_default, :event_predef
  end
end
