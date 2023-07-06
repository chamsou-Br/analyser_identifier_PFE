class SetDefaultContinuousImprovementManagerToCustomerSettings < ActiveRecord::Migration[4.2]
  def change
    Customer.all.each do |c|
        all_improver_power_managers = c.users.where(:improver_profile_type => ["admin", "manager"], deactivated: false, :continuous_improvement_manager => true).order(:lastname, :firstname)
        unless all_improver_power_managers.nil?
          default_continuous_improvement_manager_selected = all_improver_power_managers.where(:default_continuous_improvement_manager => true).first

          default_continuous_improvement_manager = nil;

          if default_continuous_improvement_manager_selected
            default_continuous_improvement_manager = default_continuous_improvement_manager_selected
          elsif c.settings.continuous_improvement_active?
            default_continuous_improvement_manager = all_improver_power_managers.first;
          end

          unless default_continuous_improvement_manager.nil?
            c.settings.update(default_continuous_improvement_manager: default_continuous_improvement_manager)
          end

        end
      end
    remove_column :users, :default_continuous_improvement_manager, :boolean
  end
end
