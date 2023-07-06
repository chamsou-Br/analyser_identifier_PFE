class SanitizeBlankProcessType < ActiveRecord::Migration[5.1]
  def change
    Rake::Task["data_migration:audit_element:sanitize_blank_process_type"].invoke
  end
end
