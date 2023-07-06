class SetIndexesToStoreConnectionAndSubscription < ActiveRecord::Migration[4.2]
  def up
    add_index :store_connections, :customer_id
    # add_index :store_connections, :connection_id, name: 'index_store_connected'
    add_index :store_connections, [:customer_id, :connection_id], :unique => true
    
    add_index :store_subscriptions, :user_id
    # add_index :store_subscriptions, :subscription_id, name: 'index_store_subscribed'
    add_index :store_subscriptions, [:user_id, :subscription_id], :unique => true
  end
  
  def down
    remove_index :store_connections, :customer_id
    # remove_index :store_connections, :connection_id
    remove_index :store_connections, [:customer_id, :connection_id]
    
    remove_index :store_subscriptions, :user_id
    # remove_index :store_subscriptions, :subscription_id
    remove_index :store_subscriptions, [:user_id, :subscription_id]
  end
end
