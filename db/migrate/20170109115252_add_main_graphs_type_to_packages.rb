class AddMainGraphsTypeToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :maingraphs_type, :integer
  end
end
