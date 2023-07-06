class AddLogoUsageToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :logo_usage, :integer, default: 0
  end
end
