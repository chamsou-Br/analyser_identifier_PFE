class AddSubjectToAuditElements < ActiveRecord::Migration[5.0]
  def change
    add_column :audit_elements, :subject, :string
  end
end
