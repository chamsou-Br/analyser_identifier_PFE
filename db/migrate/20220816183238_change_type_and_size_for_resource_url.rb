class ChangeTypeAndSizeForResourceUrl < ActiveRecord::Migration[5.2]
  def up
    change_column :resources, :url, :text
  end

  def down
    change_column :resources, :url, :string
  end
end