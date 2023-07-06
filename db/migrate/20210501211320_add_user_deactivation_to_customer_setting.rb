class AddUserDeactivationToCustomerSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_settings, :automatic_user_deactivation_enabled, :boolean, default: false, null: false, index: true
    add_column :customer_settings, :deactivation_wait_period_days, :integer, default: 30, null: false
  end
end
