class DropRolesUsers < ActiveRecord::Migration[4.2]
  def up
  	drop_table 'roles_users'
  end

  def down
    create_table "roles_users", :force => true do |t|
      t.integer  "role_id"
      t.integer  "user_id"
      t.boolean  "concern",    :default => false
      t.datetime "created_at",                    :null => false
      t.datetime "updated_at",                    :null => false
    end
  end
end
