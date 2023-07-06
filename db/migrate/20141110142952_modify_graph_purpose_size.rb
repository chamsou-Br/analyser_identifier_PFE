class ModifyGraphPurposeSize < ActiveRecord::Migration[4.2]
  def up
  	change_column :graphs, :purpose, :string, :limit => 12000
  end

  def down
  	change_column :graphs, :purpose, :string, :limit => 12000
  end
end
