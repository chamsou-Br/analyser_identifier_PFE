class RemoveAuditElementSubjectIdFromAuditEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :audit_events, :audit_element_subject_id
  end
end
