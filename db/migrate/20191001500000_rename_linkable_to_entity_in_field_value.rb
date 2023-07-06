class RenameLinkableToEntityInFieldValue < ActiveRecord::Migration[5.0]
  #
  # Rename linkable to entity to make the polymorphic association general and
  # reusable.
  #
  # @return [void]
  # @note This also requires renaming across the rest of the app.
  #
  def change
    rename_column :field_values, :linkable_id, :entity_id
    rename_column :field_values, :linkable_type, :entity_type
  end
end
