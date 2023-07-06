class CreateColors < ActiveRecord::Migration[4.2]
  def change
    create_table :colors do |t|
      t.integer :customer_setting_id
      t.string :value
      t.boolean :default, :default => false
      t.boolean :active, :default => false
      t.integer :position, :null => false
    end
    CustomerSetting.find_each do |settings|
      settings.colors.create(value: "40c353", default: true, active: true, position: 1)
      settings.colors.create(value: "e3e31f", default: true, active: true, position: 2)
      settings.colors.create(value: "e89c30", default: true, active: true, position: 3)
      settings.colors.create(value: "c53e3e", default: true, active: true, position: 4)
      settings.colors.create(value: "6a3fc4", default: true, active: true, position: 5)
      settings.colors.create(value: "333ecf", default: true, active: true, position: 6)
    end
  end
end
