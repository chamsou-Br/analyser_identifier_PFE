class AddEventTypeIdToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :event_type_id, :integer
  end
end
