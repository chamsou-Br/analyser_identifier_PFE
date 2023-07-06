class CreateEventImpacts < ActiveRecord::Migration[4.2]
  def change
    create_table :event_impacts do |t|
      t.integer :event_id
      t.integer :impact_id
    end
  end
end
