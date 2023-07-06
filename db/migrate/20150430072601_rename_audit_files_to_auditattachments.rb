class RenameAuditFilesToAuditattachments < ActiveRecord::Migration[4.2]
  def change
    rename_table :audit_files, :audit_attachments
  end
end
