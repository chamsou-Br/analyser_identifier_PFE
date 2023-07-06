class AddTypeToArrow < ActiveRecord::Migration[4.2]
  def up
    add_column :arrows, :type, :string
    Arrow.update_all(:type => "rectangular")
  end

  def down
    remove_column :arrows, :type
  end
end
