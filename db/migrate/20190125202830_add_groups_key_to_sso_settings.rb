class AddGroupsKeyToSsoSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_sso_settings, :groups_key, :string
  end
end
