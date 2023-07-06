class AddAuditElementSubjectIdToAuditEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :audit_events, :audit_element_subject_id, :integer
  end
end
