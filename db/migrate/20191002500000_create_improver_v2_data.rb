# frozen_string_literal: true

class CreateImproverV2Data < ActiveRecord::Migration[5.0]
  def change
    # Add `configurable` field to `FormField` here, which is needed by the
    # following Rake tasks.
    add_column :form_fields, :configurable, :boolean, default: false

    Rake::Task["data_migration:predef_formfield:populate_default_fields"].invoke
    Rake::Task["data_migration:audit_element:element_subject"].invoke
    Rake::Task["data_migration:audit_like:events"].invoke
    Rake::Task["data_migration:predef_formfield:criticality_field_items"].invoke
    Rake::Task["data_migration:predef_formfield:criticality_field_values"].invoke
  end
end
