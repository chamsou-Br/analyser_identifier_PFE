class AddDefaultContinuousImprovementManagerToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :customer_settings, :default_continuous_improvement_manager, :integer, after: :continuous_improvement_active, :null => true
  end
end
