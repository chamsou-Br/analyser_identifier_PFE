class CreateStoreConnections < ActiveRecord::Migration[4.2]
  def change
    create_table :store_connections do |t|
      t.belongs_to :customer
      t.references :connection, class_name: 'Customer', index: true
      t.boolean 'active'

      t.timestamps
    end
  end
end
