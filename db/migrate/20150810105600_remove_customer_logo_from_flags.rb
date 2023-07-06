class RemoveCustomerLogoFromFlags < ActiveRecord::Migration[4.2]
  def change
    remove_column :flags, :customer_logo
  end
end
