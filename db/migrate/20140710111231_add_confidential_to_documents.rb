class AddConfidentialToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :confidential, :boolean, :default => false
    Document.update_all(:confidential => false)
  end
end
