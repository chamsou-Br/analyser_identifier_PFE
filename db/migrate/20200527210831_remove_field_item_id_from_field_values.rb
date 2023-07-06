class RemoveFieldItemIdFromFieldValues < ActiveRecord::Migration[5.1]
  def up
    # IMPORTANT: Before running this migration, the field_item info needs
    # to be migrated to the entity.
    # It is preferable to run the task outside the migration to monitor the
    # change over.
    #
    Rake::Task["data_migration:field_item_to_entity:copy_to_entity"].invoke

    return unless column_exists?(:field_values, :field_item_id)

    if index_exists?(:field_values, ["form_field_id", "field_item_id", "fieldable_id", "fieldable_type"])
      puts "deleting :form_field_items"
      remove_index(:field_values, ["form_field_id", "field_item_id", "fieldable_id", "fieldable_type"])
    end

    if foreign_key_exists?(:field_values, column: :field_item_id)
      puts "deleting :foreign_key"
      remove_foreign_key(:field_values, column: :field_item_id)
    end

    if index_exists?(:field_values, :field_item_id)
      puts "deleting :field_item index"
      remove_index(:field_values, :field_item_id)
    end
    puts "deleting the actual columns"
    remove_column(:field_values, :field_item_id)
  end

  def down
    return if column_exists?(:field_values, :field_item_id)

    unless index_exists?(:field_values, :field_item)
      add_reference :field_values, :field_item, index: true, foreign_key: true, type: :integer
    end
    unless index_exists?(:field_values,
                         ["form_field_id", "field_item_id", "fieldable_id", "fieldable_type"])
      add_index(
        :field_values,
        ["form_field_id", "field_item_id", "fieldable_id", "fieldable_type"],
        name: :form_field_items
      )
    end
  end
end
