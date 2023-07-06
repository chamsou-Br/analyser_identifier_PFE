class ChangeTypeEventCustomPropertiersColumn < ActiveRecord::Migration[4.2]
  def change
    change_column :event_custom_properties, :event_setting_id, :integer
  end
end
