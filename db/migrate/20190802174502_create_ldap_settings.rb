class CreateLdapSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :ldap_settings do |t|
      t.string :host
      t.integer :port
      t.string :uid
      t.integer :encryption, default: 1
      t.string :base
      t.string :bind_dn
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.belongs_to :customer_setting

      t.timestamps
    end

    add_index :ldap_settings, :encrypted_password_iv, unique: true
  end
end
