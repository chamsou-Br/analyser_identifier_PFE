class CreateAuditFiles < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_files do |t|
      t.integer :audit_id
      t.string :title
      t.string :file

      t.timestamps
    end
  end
end
