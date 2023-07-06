class CreateImportedPackages < ActiveRecord::Migration[4.2]
  def change
    create_table :imported_packages do |t|
      t.belongs_to :package
      t.belongs_to :customer

      t.timestamps null: false
    end
  end
end
