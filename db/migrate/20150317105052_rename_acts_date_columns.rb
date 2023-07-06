class RenameActsDateColumns < ActiveRecord::Migration[4.2]
  def change
    rename_column :acts, :checked_at, :real_closed_at
    rename_column :acts, :evaluated_at, :completed_at
  end
end
