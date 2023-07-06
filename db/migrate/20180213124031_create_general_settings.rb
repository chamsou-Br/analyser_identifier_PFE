class CreateGeneralSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :general_settings do |t|
      t.string :general_setting_key
      t.string :general_setting_value
    end
  end
end
