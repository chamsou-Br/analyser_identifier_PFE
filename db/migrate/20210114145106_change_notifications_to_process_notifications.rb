class ChangeNotificationsToProcessNotifications < ActiveRecord::Migration[5.1]
  def change
    rename_table :notifications, :process_notifications
  end
end
