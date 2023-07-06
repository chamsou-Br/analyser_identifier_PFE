class AddContinuousImprovementActiveToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :continuous_improvement_active, :boolean, :default => false
  end
end
