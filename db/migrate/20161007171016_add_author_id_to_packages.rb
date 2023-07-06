class AddAuthorIdToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :packages, :author_id, :integer
  end
end
