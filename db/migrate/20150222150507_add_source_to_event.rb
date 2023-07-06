class AddSourceToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :source, :string, limit: 255
  end
end
