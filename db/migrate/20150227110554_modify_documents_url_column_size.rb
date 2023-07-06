class ModifyDocumentsUrlColumnSize < ActiveRecord::Migration[4.2]
  def up
  	change_column :documents, :url, :string, :limit => 2083
  end

  def down
  	change_column :documents, :url, :string, :limit => 255
  end
end
