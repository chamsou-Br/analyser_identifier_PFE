class RemoveReferenceFromResource < ActiveRecord::Migration[4.2]
  def up
    remove_column :resources, :reference
  end

  def down
    add_column :resources, :reference, :string
  end
end
