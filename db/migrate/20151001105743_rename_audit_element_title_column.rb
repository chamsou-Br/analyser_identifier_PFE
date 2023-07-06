class RenameAuditElementTitleColumn < ActiveRecord::Migration[4.2]
  def change
    rename_column :audit_elements, :title, :old_title
  end
end
