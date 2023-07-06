class AddActionPlansToFields < ActiveRecord::Migration[5.1]
  def up
    Rake::Task["data_migration:risk_form_fields:add_action_plans_to_form_fields"].invoke
  end

  def down
    puts "You cannot rewrite history!"
  end
end
