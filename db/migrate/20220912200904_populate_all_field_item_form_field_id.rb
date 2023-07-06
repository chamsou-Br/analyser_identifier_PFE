class PopulateAllFieldItemFormFieldId < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:required_form_field_in_field_item:delete_if_no_kin")
      Rake::Task["data_migration:required_form_field_in_field_item:delete_if_no_kin"].invoke
    else
      puts "Task required_form_field_in_field_item:delete_if_no_kin not found"
    end

    if Rake::Task.task_defined?("data_migration:required_form_field_in_field_item:add_form_field_id")
      Rake::Task["data_migration:required_form_field_in_field_item:add_form_field_id"].invoke
    else
      puts "Task required_form_field_in_field_item:add_form_field_id not found"
    end
  end

  def down
    puts "Just going down"
  end
end
