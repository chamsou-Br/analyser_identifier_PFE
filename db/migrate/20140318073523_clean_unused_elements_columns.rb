class CleanUnusedElementsColumns < ActiveRecord::Migration[4.2]
  def up
    remove_column :elements, :elementable_id
    remove_column :elements, :elementable_type
    remove_column :elements, :lft
    remove_column :elements, :rgt
  end

  def down
    add_column :elements, :elementable_id, :integer
    add_column :elements, :elementable_type, :string
    add_column :elements, :lft, :integer
    add_column :elements, :rgt, :integer
  end
end
