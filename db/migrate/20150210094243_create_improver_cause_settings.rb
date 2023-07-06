# frozen_string_literal: true

class CreateImproverCauseSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :improver_cause_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.boolean :activated
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      # setting.improver_causes.create!(by_default: true, activated: true, label: "personal")
      # setting.improver_causes.create!(by_default: true, activated: true, label: "material")
      # setting.improver_causes.create!(by_default: true, activated: true, label: "machine")
      # setting.improver_causes.create!(by_default: true, activated: true, label: "method")
      # setting.improver_causes.create!(by_default: true, activated: true, label: "management")
      # setting.improver_causes.create!(by_default: true, activated: true, label: "environment")

      execute "INSERT INTO improver_cause_settings(customer_setting_id, by_default, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, TRUE, \"personal\", now(), now());"
      execute "INSERT INTO improver_cause_settings(customer_setting_id, by_default, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, TRUE, \"material\", now(), now());"
      execute "INSERT INTO improver_cause_settings(customer_setting_id, by_default, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, TRUE, \"machine\", now(), now());"
      execute "INSERT INTO improver_cause_settings(customer_setting_id, by_default, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, TRUE, \"method\", now(), now());"
      execute "INSERT INTO improver_cause_settings(customer_setting_id, by_default, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, TRUE, \"management\", now(), now());"
      execute "INSERT INTO improver_cause_settings(customer_setting_id, by_default, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, TRUE, \"environment\", now(), now());"
    end
  end
end
