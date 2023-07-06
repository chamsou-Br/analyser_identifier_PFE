class CreateAuditElementSubjects < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_element_subjects do |t|
      t.string :subject
      t.integer :audit_id, null: false
      t.timestamps null: false
    end
  end
end
