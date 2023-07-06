class AddImproverManagersColumnsToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :events_manager, :boolean, :default => true
    add_column :users, :actions_manager, :boolean, :default => true
    add_column :users, :continuous_improvement_manager, :boolean, :default => false
    add_column :users, :default_continuous_improvement_manager, :boolean, :default => false
  end
end
