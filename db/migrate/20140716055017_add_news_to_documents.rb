class AddNewsToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :news, :string, :limit => 765
  end
end
