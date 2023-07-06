class AddAuthorIdAndResourceTypeAndPurposeToResource < ActiveRecord::Migration[4.2]
  def change
    add_column :resources, :author_id, :integer
    add_column :resources, :resource_type, :string
    add_column :resources, :purpose, :text
  end
end
