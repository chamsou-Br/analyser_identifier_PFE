class AddLocalisationPreferenceToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :localisation_preference, :integer, default: 0, :null => false
  end
end
