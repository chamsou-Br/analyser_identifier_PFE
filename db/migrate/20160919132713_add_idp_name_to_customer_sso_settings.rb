class AddIdpNameToCustomerSsoSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_sso_settings, :idp_name, :string
  end
end
