# frozen_string_literal: true

class AddCreatableToFormField < ActiveRecord::Migration[4.2]
  def change
    add_column :form_fields, :creatable, :bool, default: false
    add_column :form_fields, :visible, :bool, defautl: true
  end
end
