class AddMailWeeklyDayToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :mail_weekly_day, :integer, :default => 0
  end
end
