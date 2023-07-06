class CreatePackagePastilles < ActiveRecord::Migration[4.2]
  def change
    create_table :package_pastilles do |t|
      t.integer  "element_id",          limit: 4
      t.integer  "role_id",             limit: 4
      t.integer  "pastille_setting_id", limit: 4
      t.timestamps null: false
    end
  end
end
