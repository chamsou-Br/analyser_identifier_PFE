class AddImpactTypeToEventImpact < ActiveRecord::Migration[4.2]
  def change
    add_column :event_impacts, :impact_type, :string
    execute <<-SQL
      UPDATE event_impacts SET impact_type = 'Graph'
    SQL
  end
end
