class CreateDocumentsApprovers < ActiveRecord::Migration[4.2]
  def change
    create_table :documents_approvers do |t|
      t.integer :document_id
      t.integer :approver_id
      t.boolean :approved, :default => false, :null => false
      t.string :comment
      t.boolean :historized, :default => false, :null => false

      t.timestamps
    end
  end
end
