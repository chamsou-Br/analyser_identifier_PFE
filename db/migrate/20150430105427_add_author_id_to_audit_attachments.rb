class AddAuthorIdToAuditAttachments < ActiveRecord::Migration[4.2]
  def change
    add_column :audit_attachments, :author_id, :integer
  end
end
