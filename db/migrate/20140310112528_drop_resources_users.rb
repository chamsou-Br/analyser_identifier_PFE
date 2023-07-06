class DropResourcesUsers < ActiveRecord::Migration[4.2]
  def up
  	drop_table 'resources_users'
  end

  def down
    create_table "resources_users", :force => true do |t|
      t.integer "user_id"
      t.integer "resource_id"
      t.boolean "favorite",    :default => false
    end
  end
end
