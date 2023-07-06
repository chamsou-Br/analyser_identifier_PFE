class AddParentToElement < ActiveRecord::Migration[4.2]
  def change
    add_column :elements, :parent, :integer
  end
end
