# frozen_string_literal: true

class RenameFieldsValueToFieldValue < ActiveRecord::Migration[5.0]
  #
  # Removes the confusing `s` from `fields_values` to a more intuitive grammar
  # for native English speakers
  #
  # @return [void]
  # @note This also requires renaming the models, controllers, views in the
  #   back-end and types/interfaces in the front-end
  #
  def change
    rename_table :fields_values, :field_values
  end
end
