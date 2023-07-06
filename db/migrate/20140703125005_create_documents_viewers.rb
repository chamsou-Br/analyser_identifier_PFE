class CreateDocumentsViewers < ActiveRecord::Migration[4.2]
  def change
    create_table :documents_viewers do |t|
      t.integer :document_id
      t.integer :viewer_id
      t.string :viewer_type
    end
  end
end
