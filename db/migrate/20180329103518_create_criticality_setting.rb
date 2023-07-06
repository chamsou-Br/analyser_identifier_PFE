class CreateCriticalitySetting < ActiveRecord::Migration[4.2]
  def change
    create_table :criticality_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :custom, :default => false
      t.integer :sequence

      t.timestamps
    end
  end
end
