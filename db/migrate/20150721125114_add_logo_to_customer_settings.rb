class AddLogoToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :logo, :string
  end
end
