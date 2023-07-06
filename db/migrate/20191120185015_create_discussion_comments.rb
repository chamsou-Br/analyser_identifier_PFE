class CreateDiscussionComments < ActiveRecord::Migration[5.0]
  def change
    create_table :discussion_comments do |t|
      t.references :thread, foreign_key: { to_table: :discussion_threads },
                            null: false
      t.references :author, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
