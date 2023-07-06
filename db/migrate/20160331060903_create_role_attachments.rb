class CreateRoleAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :role_attachments do |t|
      t.references :role, index: true
      t.references :author, references: :users, index: true
      t.string :title
      t.string :file

      t.timestamps null: false
    end
    add_foreign_key :role_attachments, :roles
    add_foreign_key :role_attachments, :users, column: :author_id
  end
end
