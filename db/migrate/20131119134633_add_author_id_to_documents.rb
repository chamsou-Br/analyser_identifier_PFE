class AddAuthorIdToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :author_id, :integer
  end
end
