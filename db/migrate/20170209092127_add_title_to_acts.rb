class AddTitleToActs < ActiveRecord::Migration[4.2]
  def change
    add_column :acts, :title, :string, limit: 250, after: :id
  end
end
