class RemoveOldTitleFromAuditElements < ActiveRecord::Migration[4.2]
  def change
    remove_column :audit_elements, :old_title
  end
end
