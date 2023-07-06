class RemoveDescNlFromPastilleSettings < ActiveRecord::Migration[5.2]
  def change
    remove_column :pastille_settings, :desc_nl, :string
  end
end
