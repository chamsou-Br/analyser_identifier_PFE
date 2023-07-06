class CreatePackageLanes < ActiveRecord::Migration[4.2]
  def change
    create_table :package_lanes do |t|
      t.integer  "package_graph_id",   limit: 4
      t.decimal  "x",                    precision: 9, scale: 4
      t.decimal  "width",                precision: 9, scale: 4
      t.integer  "element_id", limit: 4
      t.timestamps null: false
    end
  end
end
