class RenameIndexInAuditParticipant < ActiveRecord::Migration[5.1]
  def change
    rename_index :audit_participants,
      "index_audit_participants_on_participant_id_and_participant_type",
      "index_audit_participants_on_participant"
  end
end
