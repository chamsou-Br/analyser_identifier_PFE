class AddCustomerLogoToFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :flags, :customer_logo, :boolean, :default => false
  end
end
