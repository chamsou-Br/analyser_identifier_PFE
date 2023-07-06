class AddLdapKeysToLdapSetting < ActiveRecord::Migration[5.0]
  def change
    add_column :ldap_settings, :email_key, :string, default: "userPrincipalName"
    add_column :ldap_settings, :firstname_key, :string, default: "givenName"
    add_column :ldap_settings, :lastname_key, :string, default: "sn"
    add_column :ldap_settings, :phone_key, :string
    add_column :ldap_settings, :mobile_phone_key, :string
    add_column :ldap_settings, :function_key, :string
    add_column :ldap_settings, :service_key, :string
    add_column :ldap_settings, :groups_key, :string
    add_column :ldap_settings, :roles_key, :string
  end
end
