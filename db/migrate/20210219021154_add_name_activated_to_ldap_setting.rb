class AddNameActivatedToLdapSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :ldap_settings, :server_name, :string, default: "My LDAP server", null: false
    add_column :ldap_settings, :enabled, :boolean, default: false, null: false
  end
end
