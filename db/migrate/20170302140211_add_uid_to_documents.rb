class AddUidToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :uid, :string, after: :id
  end
end
