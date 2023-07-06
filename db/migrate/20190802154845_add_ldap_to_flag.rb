class AddLdapToFlag < ActiveRecord::Migration[5.0]
  def change
    add_column :flags, :ldap, :boolean, default: false
  end
end
