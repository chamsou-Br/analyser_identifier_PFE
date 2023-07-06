# frozen_string_literal: true

class CreateAuditThemeSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_theme_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      execute "INSERT INTO audit_theme_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#a1671e\", TRUE, \"system\", now(), now());"
      execute "INSERT INTO audit_theme_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#cb8426\", TRUE, \"process\", now(), now());"
      execute "INSERT INTO audit_theme_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#e89c30\", TRUE, \"procedure\", now(), now());"
      execute "INSERT INTO audit_theme_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#f0bf72\", TRUE, \"product\", now(), now());"
      execute "INSERT INTO audit_theme_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#f4d49e\", TRUE, \"project\", now(), now());"
    end
  end
end
