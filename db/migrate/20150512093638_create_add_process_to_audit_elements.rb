class CreateAddProcessToAuditElements < ActiveRecord::Migration[4.2]
  def change
    add_column :audit_elements, :process_id, :integer
  end
end
