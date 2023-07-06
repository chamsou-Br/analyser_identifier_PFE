class DropGraphsUsers < ActiveRecord::Migration[4.2]
  def up
    drop_table 'graphs_users'
  end

  def down
  	create_table "graphs_users", :force => true do |t|
      t.integer  "graph_id"
      t.integer  "user_id"
      t.datetime "created_at",                    :null => false
      t.datetime "updated_at",                    :null => false
      t.boolean  "favorite",   :default => false
    end
  end
end
