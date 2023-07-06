class CreateAuditElements < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_elements do |t|
      t.integer :audit_id
      t.string :title
      t.date :start_date
      t.date :end_date

      t.references :domain_responsible, polymorphic: true

      t.timestamps null: false
    end
  end
end
