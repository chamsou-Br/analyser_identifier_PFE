class AddAuthenticationStrategyToCustomerSetting < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :authentication_strategy, :integer, default: 0
  end
end
