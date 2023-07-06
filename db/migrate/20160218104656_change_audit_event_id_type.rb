class ChangeAuditEventIdType < ActiveRecord::Migration[4.2]
  def change
    change_column :audit_element_subject_audit_events, :audit_event_id, :integer
  end
end
