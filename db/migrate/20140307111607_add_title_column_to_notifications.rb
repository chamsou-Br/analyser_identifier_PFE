class AddTitleColumnToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :title, :string
  end
end
