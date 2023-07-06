class CreateAudits < ActiveRecord::Migration[4.2]
  def change
    create_table :audits do |t|
      t.string :object
      t.string :reference
      t.string :synthesis
      t.string :state
      t.integer :customer_id
      t.integer :audit_type_id
      t.integer :owner_id
      t.integer :organizer_id
      t.date :estimated_start_at
      t.date :real_start_at
      t.date :estimated_closed_at
      t.date :real_closed_at

      t.timestamps null: false
    end
  end
end
