class AddNotificationRolesToNewNotification < ActiveRecord::Migration[4.2]
  def change
    add_column :new_notifications, :notification_roles, :text
  end
end
