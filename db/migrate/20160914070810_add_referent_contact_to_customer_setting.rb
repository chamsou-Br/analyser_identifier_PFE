class AddReferentContactToCustomerSetting < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :referent_contact, :string
  end
end
