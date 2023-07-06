class PolymorphicImpacts < ActiveRecord::Migration[4.2]
  def change
    add_column :event_impacts, :impactable_type, :string
    rename_column :event_impacts, :event_id, :impactable_id

    execute <<-SQL
      UPDATE event_impacts SET impactable_type = 'Event'
    SQL

    rename_table :event_impacts, :impactables_impacts
  end
end
