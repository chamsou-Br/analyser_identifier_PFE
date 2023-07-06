class AddDirectoryIdToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :directory_id, :integer
  end
end
