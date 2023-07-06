# frozen_string_literal: true

class CreateAuditTypeSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :audit_type_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      execute "INSERT INTO audit_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#311d5c\", TRUE, \"internal\", now(), now());"
      execute "INSERT INTO audit_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#452882\", TRUE, \"external\", now(), now());"
      execute "INSERT INTO audit_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#5934a7\", TRUE, \"certification\", now(), now());"
      execute "INSERT INTO audit_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#6a3fc4\", TRUE, \"diagnostic\", now(), now());"
      execute "INSERT INTO audit_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#9197e5\", TRUE, \"evaluation\", now(), now());"
    end
  end
end
