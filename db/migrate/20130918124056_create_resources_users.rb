class CreateResourcesUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :resources_users do |t|
      t.integer :user_id
      t.integer :resource_id
      t.boolean :favorite, :default => false
    end
  end
end
