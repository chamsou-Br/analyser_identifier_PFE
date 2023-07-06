class MoveTripleSystemAssociationToOne < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:risk_scale_by_type:copy_ids_and_types")
      Rake::Task["data_migration:risk_scale_by_type:copy_ids_and_types"].invoke
    else
      puts "Pesky triples are gone"
    end
  end

  def down
    puts "Single to triple to single makes no sense!"
  end
end
