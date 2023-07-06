class CreateTimelineAudits < ActiveRecord::Migration[4.2]
  def change
    create_table :timeline_audits do |t|
      t.integer :author_id
      t.integer :audit_id
      t.text :object
      t.string :comment
      t.string :action

      t.timestamps null: false
    end
  end
end
