class AddFormFieldCriticalityCalculated < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:criticality:add_criticality_calculated")
      Rake::Task["data_migration:criticality:add_criticality_calculated"].invoke
    else
      puts "The calculating of the criticiality was done."
    end
  end

  def down
    puts "Recalculate the incalculatable!"
  end
end
