class ModifyElementTextSize < ActiveRecord::Migration[4.2]
  def up
  	change_column :elements, :text, :text, :limit => 1200
  end

  def down
  	change_column :elements, :text, :string, :limit => 255
  end
end
