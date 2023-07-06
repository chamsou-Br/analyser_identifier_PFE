class ChangeOccurrenceDateFromEvent < ActiveRecord::Migration[4.2]
  def change
    change_column :events, :occurrence_date, :date
    rename_column :events, :occurrence_date, :occurrence_at
  end
end
