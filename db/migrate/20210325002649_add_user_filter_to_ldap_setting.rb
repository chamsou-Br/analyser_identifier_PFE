class AddUserFilterToLdapSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :ldap_settings, :filter, :string, default: "", null: false
  end
end
