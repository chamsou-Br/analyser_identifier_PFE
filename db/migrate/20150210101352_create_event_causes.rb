class CreateEventCauses < ActiveRecord::Migration[4.2]
  def change
    create_table :event_causes do |t|
      t.integer :event_id 
      t.integer :cause_id 
    end
  end
end
