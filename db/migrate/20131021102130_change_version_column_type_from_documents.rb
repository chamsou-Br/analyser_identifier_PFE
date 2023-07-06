class ChangeVersionColumnTypeFromDocuments < ActiveRecord::Migration[4.2]
  def change
    change_column :documents, :version, :string
  end
end
