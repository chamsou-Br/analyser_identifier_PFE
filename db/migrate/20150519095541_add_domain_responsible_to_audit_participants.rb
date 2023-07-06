class AddDomainResponsibleToAuditParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :audit_participants, :domain_responsible, :boolean, default: false
  end
end
