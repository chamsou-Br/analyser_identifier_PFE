class AddDefaultPortToLdapSetting < ActiveRecord::Migration[5.0]
  def up
    change_column_default :ldap_settings, :port, 389
  end

  def down
    change_column_default :ldap_settings, :port, nil
  end
end
