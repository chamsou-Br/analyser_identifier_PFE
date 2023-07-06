class CreatePackageConnections < ActiveRecord::Migration[4.2]
  def change
    create_table :package_connections do |t|
      t.integer :package_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
