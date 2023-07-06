class AddImportedPackageIdToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :imported_package_id, :integer
  end
end
