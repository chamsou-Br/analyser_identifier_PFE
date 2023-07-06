class AddAuditElementSubjectIdToAuditElements < ActiveRecord::Migration[4.2]
  def change
  	add_column :audit_elements, :audit_element_subject_id, :integer
  end
end
