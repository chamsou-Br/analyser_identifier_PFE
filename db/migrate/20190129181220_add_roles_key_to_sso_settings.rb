class AddRolesKeyToSsoSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_sso_settings, :roles_key, :string
  end
end
