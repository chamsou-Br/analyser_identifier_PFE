class AddMappingAttributesToCustomerSsoSetting < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_sso_settings, :email_key, :string
    add_column :customer_sso_settings, :firstname_key, :string
    add_column :customer_sso_settings, :lastname_key, :string
  end
end
