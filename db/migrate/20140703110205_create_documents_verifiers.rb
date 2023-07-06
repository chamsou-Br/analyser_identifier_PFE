class CreateDocumentsVerifiers < ActiveRecord::Migration[4.2]
  def change
    create_table :documents_verifiers do |t|
      t.integer :document_id
      t.integer :verifier_id
      t.boolean :verified, :null => false, :default => false
      t.string :comment
      t.boolean :historized, :null => false, :default => false

      t.timestamps
    end
  end
end
