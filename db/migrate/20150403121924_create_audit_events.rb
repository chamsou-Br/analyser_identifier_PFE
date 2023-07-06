class CreateAuditEvents < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_events do |t|
      t.integer :audit_id
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
