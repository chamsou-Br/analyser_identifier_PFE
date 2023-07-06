class AddDefaultUidToLdapSettings < ActiveRecord::Migration[5.0]
  def up
    change_column_default :ldap_settings, :uid, "sAMAccountName"
  end

  def down
    change_column_default :ldap_settings, :uid, nil
  end
end
