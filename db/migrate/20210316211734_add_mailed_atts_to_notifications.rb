class AddMailedAttsToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :mailed_date, :datetime
    add_column :notifications, :mailed_frequency, :integer
  end
end
