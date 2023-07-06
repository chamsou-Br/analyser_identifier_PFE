# frozen_string_literal: true

class CreateImproverTypeSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :improver_type_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.string :model
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      # setting.improver_types.create!(by_default: true, color: "#311d5c", model: "Event", activated: true, label: "non_compliance")
      # setting.improver_types.create!(by_default: true, color: "#452882", model: "Event", activated: true, label: "sensitive_point")
      # setting.improver_types.create!(by_default: true, color: "#5934a7", model: "Event", activated: true, label: "lead_of_improvement")
      # setting.improver_types.create!(by_default: true, color: "#6a3fc4", model: "Event", activated: true, label: "strong_point")
      # setting.improver_types.create!(by_default: true, color: "#9197e5", model: "Event", activated: true, label: "work_accident")
      # setting.improver_types.create!(by_default: true, color: "#ae97df", model: "Event", activated: true, label: "customer_complaint")

      # Cette table étant renommée dans une migration postérieure, il faut passer par du SQL pur.
      execute "INSERT INTO improver_type_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#311d5c\", \"Event\", TRUE, \"non_compliance\", now(), now());"
      execute "INSERT INTO improver_type_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#452882\", \"Event\", TRUE, \"sensitive_point\", now(), now());"
      execute "INSERT INTO improver_type_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#5934a7\", \"Event\", TRUE, \"lead_of_improvement\", now(), now());"
      execute "INSERT INTO improver_type_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#6a3fc4\", \"Event\", TRUE, \"strong_point\", now(), now());"
      execute "INSERT INTO improver_type_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#9197e5\", \"Event\", TRUE, \"work_accident\", now(), now());"
      execute "INSERT INTO improver_type_settings(customer_setting_id, by_default, color, model, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#ae97df\", \"Event\", TRUE, \"customer_complaint\", now(), now());"
    end
  end
end
