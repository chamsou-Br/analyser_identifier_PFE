class CreateStoreSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :store_subscriptions do |t|
      t.belongs_to :user
      t.references :subscription, class_name: 'Customer', index: true
      t.boolean 'enable'

      t.timestamps
    end
  end
end
