class ChangeSizeInPastilleSettings < ActiveRecord::Migration[5.1]
  def up
    change_column :pastille_settings, :label, :string, limit: 3
  end

  def down
    change_column :pastille_settings, :label, :string, limit: 1
  end
end
