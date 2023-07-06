class AddPasswordPolicyEnabledToCustomerSetting < ActiveRecord::Migration[5.0]
  def change
    add_column :customer_settings, :password_policy_enabled, :boolean, default: false
  end
end
