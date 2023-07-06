class RemoveResponsibleFromAuditElement < ActiveRecord::Migration[4.2]
  def change
    remove_column :audit_elements, :domain_responsible_id
    remove_column :audit_elements, :domain_responsible_type
  end
end
