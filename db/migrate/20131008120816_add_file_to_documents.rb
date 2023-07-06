class AddFileToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :file, :string
  end
end
