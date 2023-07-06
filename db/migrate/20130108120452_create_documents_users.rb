class CreateDocumentsUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :documents_users do |t|
      t.integer :user_id
      t.integer :document_id
      t.boolean :favorite, :default => false
    end
  end
end
