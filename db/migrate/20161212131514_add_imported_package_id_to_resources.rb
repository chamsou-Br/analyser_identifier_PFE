class AddImportedPackageIdToResources < ActiveRecord::Migration[4.2]
  def change
    add_column :resources, :imported_package_id, :integer
  end
end
