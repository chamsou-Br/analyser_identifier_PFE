class ChangeEventsState < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :state
    add_column :events, :state, :integer, default: 0
  end
end
