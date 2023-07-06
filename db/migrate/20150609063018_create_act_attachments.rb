class CreateActAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :act_attachments do |t|
      t.integer :act_id
      t.string :title
      t.string :file
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
