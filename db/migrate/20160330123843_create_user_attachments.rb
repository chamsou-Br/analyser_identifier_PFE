class CreateUserAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :user_attachments do |t|
      t.integer :user_id
      t.string :title
      t.string :file
      
      t.timestamps null: false
    end
  end
end
