class CreateRolesUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :roles_users do |t|
      t.integer :role_id
      t.integer :user_id
      t.boolean :concerne, :default => false

      t.timestamps
    end
  end
end
