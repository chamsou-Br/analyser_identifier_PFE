# frozen_string_literal: true

class CreateFormFields < ActiveRecord::Migration[4.2]
  def change
    create_table :form_fields do |t|
      t.belongs_to :customer, index: true, foreign_key: true
      t.integer :module
      t.integer :form_type
      t.integer :field_type
      t.string :label
      t.string :field_name
      t.boolean :custom
      t.boolean :required
      t.integer :position, null: false

      t.timestamps null: false
    end
    add_index(:form_fields, %i[customer_id module form_type])
  end
end
