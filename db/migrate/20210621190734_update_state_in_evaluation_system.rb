class UpdateStateInEvaluationSystem < ActiveRecord::Migration[5.1]
  def up
    if Rake::Task.task_defined?("data_migration:evaluation_system:update_state")
      Rake::Task["data_migration:evaluation_system:update_state"].invoke
    else
      puts "There were no diamonds..."
    end
  end

  def down
    puts "No pressure, no diamond"
  end
end
