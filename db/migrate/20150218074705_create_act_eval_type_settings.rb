# frozen_string_literal: true

class CreateActEvalTypeSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :act_eval_type_settings do |t|
      t.integer :customer_setting_id
      t.string :label
      t.string :color
      t.boolean :activated
      t.boolean :by_default, default: false

      t.timestamps
    end

    CustomerSetting.all.each do |setting|
      # ActEvalTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#A3A3A3", label: "indicator")
      # ActEvalTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#BABABA", label: "audit")
      # ActEvalTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#D1D1D1", label: "management_feedback")
      # ActEvalTypeSetting.create!(customer_setting_id: setting.id, by_default: true, activated: true, color: "#E8E8E8", label: "customer_feedback")

      execute "INSERT INTO act_eval_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#A3A3A3\", TRUE, \"indicator\", now(), now());"
      execute "INSERT INTO act_eval_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#BABABA\", TRUE, \"audit\", now(), now());"
      execute "INSERT INTO act_eval_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#D1D1D1\", TRUE, \"management_feedback\", now(), now());"
      execute "INSERT INTO act_eval_type_settings(customer_setting_id, by_default, color, activated, label, created_at, updated_at) VALUES(\"#{setting.id}\", TRUE, \"#E8E8E8\", TRUE, \"customer_feedback\", now(), now());"
    end
  end
end
