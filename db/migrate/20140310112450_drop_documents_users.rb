class DropDocumentsUsers < ActiveRecord::Migration[4.2]
  def up
  	drop_table 'documents_users'
  end

  def down
  	create_table "documents_users", :force => true do |t|
      t.integer "user_id"
      t.integer "document_id"
      t.boolean "favorite",    :default => false
    end
  end
end
