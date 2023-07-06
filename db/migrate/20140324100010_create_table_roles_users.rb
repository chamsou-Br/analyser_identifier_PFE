class CreateTableRolesUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :roles_users, :force => true do |t|
      t.integer  :role_id
      t.integer  :user_id

      t.timestamps
    end
  end
end