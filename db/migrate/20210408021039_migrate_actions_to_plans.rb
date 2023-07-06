class MigrateActionsToPlans < ActiveRecord::Migration[5.1]
  def up
    Rake::Task["data_migration:acts_risks_to_plans:create_action_plans"].invoke
  end

  def down
    puts "Do nothing"
  end
end
