class UserWorkingDateToDatetime < ActiveRecord::Migration[5.2]
  def up
    if Rake::Task.task_defined?("data_migration:user:user_working_date_to_datetime")
      Rake::Task["data_migration:user:user_working_date_to_datetime"].invoke
      change_column :users, :working_date, :datetime
    else
      puts "Task use_working_date_to_datetime not found"
    end
  end

  def down
    change_column :users, :working_date, :string
  end
end
