class CreateAuditElementSubjectAuditEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_element_subject_audit_events do |t|
      t.integer :audit_element_subject_id
      t.string :audit_event_id

      t.timestamps null: false
    end
  end
end
