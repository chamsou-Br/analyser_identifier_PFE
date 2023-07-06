class AddOwnerUsersManagementToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :owner_users_management, :boolean, :default => false
  end
end
