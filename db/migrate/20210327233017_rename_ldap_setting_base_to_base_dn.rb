class RenameLdapSettingBaseToBaseDn < ActiveRecord::Migration[5.1]
  def change
    rename_column :ldap_settings, :base, :base_dn
  end
end
