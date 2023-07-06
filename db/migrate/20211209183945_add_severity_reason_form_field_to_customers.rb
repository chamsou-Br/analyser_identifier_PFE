class AddSeverityReasonFormFieldToCustomers < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:severity_reason:add_form_field")
      Rake::Task["data_migration:severity_reason:add_form_field"].invoke
    else
      puts "The severity of the reasoning could not be found."
    end
  end

  def down
    puts "Reason and Gravity down they go."
  end
end
