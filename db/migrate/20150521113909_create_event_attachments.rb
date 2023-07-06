class CreateEventAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :event_attachments do |t|
      t.integer :event_id
      t.string :title
      t.string :file
      t.integer :author_id

      t.timestamps
    end
  end
end
