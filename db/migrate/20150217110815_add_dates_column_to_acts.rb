class AddDatesColumnToActs < ActiveRecord::Migration[4.2]
  def change
    add_column :acts, :real_started_at, :date
    add_column :acts, :checked_at, :date
    add_column :acts, :evaluated_at, :date
  end
end
