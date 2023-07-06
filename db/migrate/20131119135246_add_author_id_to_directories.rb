class AddAuthorIdToDirectories < ActiveRecord::Migration[4.2]
  def change
    add_column :directories, :author_id, :integer
  end
end
