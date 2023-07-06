class SetDefaultValueToStoreConnectionAndSubscription < ActiveRecord::Migration[4.2]
  
  def up
    change_column :store_connections, :active, :boolean, :default => false
    change_column :store_subscriptions, :enable, :boolean, :default => false
  end

  def down
    change_column :store_connections, :active, :boolean, :default => nil
    change_column :store_subscriptions, :enable, :boolean, :default => nil
  end
  
end
