class AddTitlePositionToElements < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :titlePosition, :string, :default => "middle"
  end
end
