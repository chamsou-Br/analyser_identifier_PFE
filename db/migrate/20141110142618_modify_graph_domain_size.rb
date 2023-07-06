class ModifyGraphDomainSize < ActiveRecord::Migration[4.2]
  def up
  	change_column :graphs, :domain, :text, :limit => 12000
  end

  def down
  	change_column :graphs, :domain, :string, :limit => 255
  end

end
