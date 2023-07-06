class AddPrintFooterToGraphsAndDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :print_footer, :string, :limit => 100
    add_column :documents, :print_footer, :string, :limit => 100
  end
end
