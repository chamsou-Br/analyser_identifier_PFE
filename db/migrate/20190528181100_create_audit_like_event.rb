class CreateAuditLikeEvent < ActiveRecord::Migration[5.0]
  def change
    create_table :audit_like_events do |t|
      t.integer :event_id
      t.integer :audit_like_id
      t.string :audit_like_type
      t.timestamps
    end
    add_index :audit_like_events, [:audit_like_id, :audit_like_type]
    add_index :audit_like_events, :event_id
  end
end
