class AddCustomerIdToNewNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :new_notifications, :customer_id, :integer
  end
end
