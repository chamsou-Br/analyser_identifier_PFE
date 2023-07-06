class NormalizeBooleanInStoreConnectionSubscription < ActiveRecord::Migration[4.2]
  def change
    rename_column :store_connections, :active, :enabled
    rename_column :store_subscriptions, :enable, :enabled
    change_column :store_connections, :enabled, :boolean, :default => false
    change_column :store_subscriptions, :enabled, :boolean, :default => false
  end
end
