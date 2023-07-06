class AddActivatedToCriticalitySettings < ActiveRecord::Migration[4.2]
  def change
    add_column :criticality_settings, :activated, :boolean, default: true
  end
end
