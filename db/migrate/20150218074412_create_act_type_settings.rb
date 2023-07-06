# frozen_string_literal: true

class CreateActTypeSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :act_type_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      # ActTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#65BAF8", label: "preventive")
      # ActTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#DD8CB7", label: "corrective")
      # ActTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#B0C64B", label: "improvement")

      execute "INSERT INTO act_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#65BAF8\", TRUE, \"preventive\", now(), now());"
      execute "INSERT INTO act_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#DD8CB7\", TRUE, \"corrective\", now(), now());"
      execute "INSERT INTO act_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#B0C64B\", TRUE, \"improvement\", now(), now());"
    end
  end
end
