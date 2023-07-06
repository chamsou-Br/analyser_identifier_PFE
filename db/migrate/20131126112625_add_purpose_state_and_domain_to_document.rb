class AddPurposeStateAndDomainToDocument < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :purpose, :string, :limit => 765
    add_column :documents, :state, :string
    add_column :documents, :domain, :string, :limit => 765
  end
end
