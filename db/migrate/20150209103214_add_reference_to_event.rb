class AddReferenceToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :reference, :string, limit: 255
  end
end
