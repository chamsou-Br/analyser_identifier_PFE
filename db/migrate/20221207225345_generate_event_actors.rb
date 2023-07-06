class GenerateEventActors < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:event_improver_actors:for_event")
      Rake::Task["data_migration:event_improver_actors:for_event"].invoke
    else
      puts "Task event_improver_actors:for_event not found"
    end
  end

  def down
    puts "Actors already acted!"
  end
end
