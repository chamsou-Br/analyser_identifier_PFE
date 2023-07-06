class AddRootToGroupgraphs < ActiveRecord::Migration[4.2]
  def change
  	add_column :groupgraphs, :root, :boolean, default: false
  end
end
