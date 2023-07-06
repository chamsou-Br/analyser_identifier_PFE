class PopulateEvalSystemIdInSevReason < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:severity_reason_eval_system:applicable_eval_system")
      Rake::Task["data_migration:severity_reason_eval_system:applicable_eval_system"].invoke
    else
      puts "Task severity_reason_eval_system:applicable_eval_system not found"
    end
  end

  def down
    puts "Reasons already given!"
  end
end
