class AddCompositeIndexToAuditLikeEvent < ActiveRecord::Migration[5.0]
  def change
    add_index(:audit_like_events, [:event_id, :audit_like_id, :audit_like_type], unique: true, name: "audit_event_link")
  end
end
