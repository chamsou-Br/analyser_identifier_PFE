class CreateAuditThemes < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_themes do |t|
      t.integer :audit_id
      t.integer :theme_id
    end
  end
end
