# frozen_string_literal: true

class CreateImproverDomainSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :improver_domain_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.string :model
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      # setting.improver_domains.create!(by_default: true, color: "#e89c30", model: "Event", activated: true, label: "quality")
      # setting.improver_domains.create!(by_default: true, color: "#f0bf72", model: "Event", activated: true, label: "security")
      # setting.improver_domains.create!(by_default: true, color: "#f4d49e", model: "Event", activated: true, label: "environment")

      # Cette table étant renommée dans une migration postérieure, il faut passer par du SQL pur.
      execute "INSERT INTO improver_domain_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#e89c30\", \"Event\", TRUE, \"quality\", now(), now());"
      execute "INSERT INTO improver_domain_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#f0bf72\", \"Event\", TRUE, \"security\", now(), now());"
      execute "INSERT INTO improver_domain_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#f4d49e\", \"Event\", TRUE, \"environment\", now(), now());"
    end
  end
end
