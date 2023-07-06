class CreatePackageResources < ActiveRecord::Migration[4.2]
  def change
    create_table :package_resources do |t|
      t.integer  "package_id", limit: 4
      t.integer  "resource_id", limit: 4
      t.string   "title",         limit: 255
      t.string   "url",           limit: 255
      t.string   "resource_type", limit: 255
      t.text     "purpose",       limit: 65535
      t.string   "logo",          limit: 255
      t.timestamps null: false
    end
  end
end
