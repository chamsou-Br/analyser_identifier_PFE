class CreateEventCustomProperties < ActiveRecord::Migration[4.2]
  def change
    create_table :event_custom_properties do |t|
      t.integer :customer_id
      t.integer :event_id
      t.string :event_setting_id
      t.string :value

      t.timestamps
    end
  end
end
