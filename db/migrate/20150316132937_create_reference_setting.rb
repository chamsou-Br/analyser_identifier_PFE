class CreateReferenceSetting < ActiveRecord::Migration[4.2]
  def change
    create_table :reference_settings do |t|
      t.integer :customer_setting_id
      t.string :event_prefix
      t.string :act_prefix
    end
  end
end
