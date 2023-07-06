class CreateDocumentsLogs < ActiveRecord::Migration[4.2]
  def change
    create_table :documents_logs do |t|    
      t.integer :document_id
      t.string :action
      t.string :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
