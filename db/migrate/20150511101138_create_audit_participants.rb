class CreateAuditParticipants < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_participants do |t|

      t.integer :audit_element_id

      t.boolean :auditor
      t.boolean :audited

      t.references :participant, polymorphic: true

      t.timestamps null: false
    end
  end
end
