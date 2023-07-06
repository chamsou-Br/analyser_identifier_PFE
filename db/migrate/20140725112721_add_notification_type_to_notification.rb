class AddNotificationTypeToNotification < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :notification_type, :string, default: 'information'
  end
end
