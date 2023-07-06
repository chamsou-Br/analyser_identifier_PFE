# frozen_string_literal: true

class AddParentIdToFieldItem < ActiveRecord::Migration[5.0]
  def change
    add_column :field_items, :parent_id, :integer
  end
end
