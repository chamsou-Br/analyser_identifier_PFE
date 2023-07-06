class CustomerSsoSettingBelongsToCustomerSetting < ActiveRecord::Migration[4.2]
  def up
    rename_column :customer_sso_settings, :customer_id, :customer_setting_id
  end

  def down
  end
end
