class AddCheckedAtToNewNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :new_notifications, :checked_at, :datetime
  end
end
