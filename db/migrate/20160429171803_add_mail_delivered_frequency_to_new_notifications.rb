class AddMailDeliveredFrequencyToNewNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :new_notifications, :mail_delivered_frequency, :string

    NewNotification.update_all(mail_delivered_frequency: 'real_time')

  end
end
