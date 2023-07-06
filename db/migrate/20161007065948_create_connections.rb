class CreateConnections < ActiveRecord::Migration[4.2]
  def change
    create_table :connections do |t|
      t.belongs_to 'customer1', class_name: 'Customer'
      t.belongs_to 'customer2', class_name: 'Customer'
      t.integer 'customer1_status'
      t.timestamp 'customer1_status_at'
      t.integer 'customer2_status'
      t.timestamp 'customer2_status_at'
      t.boolean 'customer1_following_customer2'
      t.boolean 'customer2_following_customer1'

      t.timestamps
    end
  end
end
