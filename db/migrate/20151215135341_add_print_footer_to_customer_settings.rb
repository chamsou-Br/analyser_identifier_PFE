class AddPrintFooterToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :print_footer, :string, :limit => 100
  end
end
