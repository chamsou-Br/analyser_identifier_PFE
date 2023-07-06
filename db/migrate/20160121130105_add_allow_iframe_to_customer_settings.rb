class AddAllowIframeToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :allow_iframe, :boolean, default: false
  end
end
