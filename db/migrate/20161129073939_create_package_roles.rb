class CreatePackageRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :package_roles do |t|
      t.integer  "package_id", limit:4
      t.integer  "role_id", limit: 4
      t.string   "title",       limit: 255
      t.string   "type",        limit: 255
      t.string   "mission",     limit: 2300
      t.string   "activities",  limit: 2300
      t.string   "purpose",     limit: 2300
      t.timestamps null: false
    end
  end
end
