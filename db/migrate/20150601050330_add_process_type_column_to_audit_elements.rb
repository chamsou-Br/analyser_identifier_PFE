class AddProcessTypeColumnToAuditElements < ActiveRecord::Migration[4.2]
  def change
    add_column :audit_elements, :process_type, :string
    AuditElement.update_all(:process_type => 'Graph')
  end
end
