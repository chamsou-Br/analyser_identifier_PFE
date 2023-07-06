class MvEvalSystemIdToEval < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:evaluation_system_id:mv_eval_system_id_from_risk")
      Rake::Task["data_migration:evaluation_system_id:mv_eval_system_id_from_risk"].invoke
    else
      puts "It ain't here!"
    end
  end

  def down
    puts "What are you looking at?"
  end
end
