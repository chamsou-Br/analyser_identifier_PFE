class CreatePackageCategories < ActiveRecord::Migration[4.2]
  def up
    create_table :package_categories do |t|
      t.belongs_to :package
      t.belongs_to :static_package_category

      t.timestamps null: false
    end
  end

  def down
    drop_table :package_categories
  end
end
