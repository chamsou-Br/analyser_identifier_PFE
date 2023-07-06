class AddUidsToPackageDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :package_documents, :document_uid, :string, after: :document_id
    add_column :package_documents, :groupdocument_uid, :string, after: :groupdocument_id
  end
end
