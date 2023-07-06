class AddImportedUidsToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :imported_uid, :string
    add_column :documents, :imported_groupdocument_uid, :string
  end
end
