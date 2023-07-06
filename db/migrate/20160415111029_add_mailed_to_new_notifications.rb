class AddMailedToNewNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :new_notifications, :mailed, :datetime

    NewNotification.update_all(mailed: DateTime.now)

  end
end
