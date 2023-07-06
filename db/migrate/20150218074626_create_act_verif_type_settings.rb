# frozen_string_literal: true

class CreateActVerifTypeSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :act_verif_type_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      # ActVerifTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#6EDC6C", label: "control")
      # ActVerifTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#99E394", label: "audit")

      execute "INSERT INTO act_verif_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#6EDC6C\", TRUE, \"control\", now(), now());"
      execute "INSERT INTO act_verif_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#99E394\", TRUE, \"audit\", now(), now());"
    end
  end
end
