class RemoveDescriptionFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :description, :string
  end
end
