# frozen_string_literal: true

class AddEventDefaultToFormField < ActiveRecord::Migration[4.2]
  def change
    add_column :form_fields, :event_default, :integer, default: nil
  end
end
