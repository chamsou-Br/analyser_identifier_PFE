class RemoveDailyMailFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :daily_mail
  end
end
