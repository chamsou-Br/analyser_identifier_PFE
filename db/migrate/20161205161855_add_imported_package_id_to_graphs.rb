class AddImportedPackageIdToGraphs < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :imported_package_id, :integer
  end
end
