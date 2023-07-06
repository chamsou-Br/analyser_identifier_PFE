class AddClosedAtToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :closed_at, :date
  end
end
